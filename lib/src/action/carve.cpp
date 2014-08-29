#define GLM_FORCE_RADIANS
#include <unordered_set>
#include <set>
#include <glm/glm.hpp>
#include <glm/gtx/norm.hpp>
#include "action/carve.hpp"
#include "id.hpp"
#include "action/unit/on.hpp"
#include "action/subdivide.hpp"
#include "partial-action/modify-winged-vertex.hpp"
#include "primitive/sphere.hpp"
#include "carve-brush.hpp"
#include "winged/face.hpp"
#include "winged/mesh.hpp"
#include "winged/vertex.hpp"
#include "intersection.hpp"

struct ActionCarve::Impl {
  ActionCarve*              self;
  ActionUnitOn <WingedMesh> actions;

  Impl (ActionCarve* s) : self (s) {}

  void runUndoBeforePostProcessing (WingedMesh& mesh) { this->actions.undo (mesh); }
  void runRedoBeforePostProcessing (WingedMesh& mesh) { this->actions.redo (mesh); }

  void run (const CarveBrush& brush) { 
    std::vector <WingedFace*> faces;
    PrimSphere                sphere (brush.position (), brush.width ());
    WingedMesh&               mesh   = brush.mesh ();

    mesh.intersects      (sphere, faces);
    mesh.addInterimFaces (true);
    this->subdivideFaces (
          mesh, sphere, faces
        , [this,&brush] (const WingedFace& f) { return this->isSubdividable (brush, f); });

    this->carveFaces (
          mesh, faces
        , [this,&brush] (const glm::vec3& n, const glm::vec3& p) { 
            return this->carveVertex (brush, n, p); 
          });

    mesh.addInterimFaces   (false);
    this->self->bufferData (mesh);
  }

  bool isSubdividable (const CarveBrush& brush, const WingedFace& face) const
  {
    const glm::vec3 v1 = face.firstVertex  ().vector (brush.mesh ());
    const glm::vec3 v2 = face.secondVertex ().vector (brush.mesh ());
    const glm::vec3 v3 = face.thirdVertex  ().vector (brush.mesh ());

    const float maxEdgeLength = glm::max ( glm::distance2 (v1, v2)
                                         , glm::max ( glm::distance2 (v1, v3)
                                                    , glm::distance2 (v2, v3)));

    return maxEdgeLength > brush.detail () * brush.detail ();
  }

  void subdivideFaces 
    ( WingedMesh& mesh, const PrimSphere& sphere, std::vector <WingedFace*>& faces
    , const std::function <bool (const WingedFace&)>& isSubdividable )
  {
    std::unordered_set <Id> thisIteration;
    std::unordered_set <Id> nextIteration;
    std::unordered_set <Id> affectedFaces;

    auto checkNextIteration = [&] (const WingedFace& face) -> void {
      if ( nextIteration.count (face.id ()) == 0 
        && isSubdividable (face)
        && IntersectionUtil::intersects (sphere,mesh,face)) 
      {
        nextIteration.insert (face.id ());
      }
    };

    // initialize first iteration
    for (WingedFace* face : faces) {
      assert (face);
      thisIteration.insert (face->id ());
      affectedFaces.insert (face->id ());
    }

    // iterate
    while (thisIteration.size () > 0) {
      for (const Id& id : thisIteration) {
        WingedFace* f = mesh.face (id);
        if (f && isSubdividable (*f)) {
          std::vector <Id> tmpAffected;
          this->actions.add <ActionSubdivide> ().run (mesh, *f, &tmpAffected);

          for (const Id& id : tmpAffected) {
            WingedFace* affected = mesh.face (id);
            if (affected) {
              checkNextIteration   (*affected);
              affectedFaces.insert (id);
            }
          }
        }
      }
      thisIteration = nextIteration;
      nextIteration.clear ();
    }

    // collect affected faces
    faces.clear ();
    for (const Id& id : affectedFaces) {
      WingedFace* affected = mesh.face (id);
      if (affected) {
        faces.push_back (affected);
      }
    }
  }

  glm::vec3 carveVertex ( const CarveBrush& brush, const glm::vec3& normal
                        , const glm::vec3& pos) const 
  {
    const float delta = brush.y (glm::distance <float> (pos, brush.position ()));
    return pos + (normal * delta);
  }

  void carveFaces ( WingedMesh& mesh, std::vector <WingedFace*>& faces
                  , const std::function <glm::vec3 (const glm::vec3&, const glm::vec3&)>& carve ) 
  {
    // compute set of vertices
    std::set <WingedVertex*> vertices;
    for (const WingedFace* face : faces) {
      assert (face);
      vertices.insert (&face->firstVertex  ());
      vertices.insert (&face->secondVertex ());
      vertices.insert (&face->thirdVertex  ());
    }

    // write normals
    glm::vec3 avgNormal (0.0f);
    for (WingedVertex* v : vertices) {
      const glm::vec3 n         = v->interpolatedNormal (mesh);
                      avgNormal = avgNormal + n;
      this->actions.add <PAModifyWVertex> ().writeNormal (mesh,*v, n);
    }
    avgNormal = avgNormal / float (vertices.size ());

    // write new positions
    for (WingedVertex* v : vertices) {
      const glm::vec3 newPos = carve (avgNormal, v->vector (mesh));

      this->actions.add <PAModifyWVertex> ().move (mesh, *v, newPos);
    }

    // write normals
    for (WingedVertex* v : vertices) {
      this->actions.add <PAModifyWVertex> ().writeNormal (mesh,*v, v->interpolatedNormal (mesh));
    }

    // realign faces
    for (auto it = faces.begin (); it != faces.end (); ++it) {
      WingedFace* face = *it;
      assert (face);
      *it = &this->self->realignFace (mesh, *face);
    }
  }
};

DELEGATE_BIG3_SELF (ActionCarve)
DELEGATE1          (void, ActionCarve, run, const CarveBrush&)
DELEGATE1          (void, ActionCarve, runUndoBeforePostProcessing, WingedMesh&)
DELEGATE1          (void, ActionCarve, runRedoBeforePostProcessing, WingedMesh&)
