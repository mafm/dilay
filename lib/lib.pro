include (../common.pri)

TEMPLATE     = lib
TARGET       = dilay
DEPENDPATH  += src 
INCLUDEPATH += src 
CONFIG      += staticlib

SOURCES += \
           src/action/finalize.cpp \
           src/action/sculpt.cpp \
           src/action/subdivide-mesh.cpp \
           src/adjacent-iterator.cpp \
           src/affected-faces.cpp \
           src/camera.cpp \
           src/color.cpp \
           src/config.cpp \
           src/configurable.cpp \
           src/dimension.cpp \
           src/history.cpp \
           src/index-octree.cpp \
           src/intersection.cpp \
           src/kvstore.cpp \
           src/mesh.cpp \
           src/mesh-util.cpp \
           src/mirror.cpp \
           src/opengl.cpp \
           src/opengl-buffer-id.cpp \
           src/partial-action/collapse-edge.cpp \
           src/partial-action/collapse-face.cpp \
           src/partial-action/delete-edge-face.cpp \
           src/partial-action/delete-valence-3-vertex.cpp \
           src/partial-action/delete-vertex.cpp \
           src/partial-action/flip-edge.cpp \
           src/partial-action/insert-edge-face.cpp \
           src/partial-action/insert-edge-vertex.cpp \
           src/partial-action/relax-edge.cpp \
           src/partial-action/smooth.cpp \
           src/partial-action/subdivide-edge.cpp \
           src/partial-action/triangulate-6-gon.cpp \
           src/partial-action/triangulate-quad.cpp \
           src/primitive/aabox.cpp \
           src/primitive/cone.cpp \
           src/primitive/cylinder.cpp \
           src/primitive/plane.cpp \
           src/primitive/ray.cpp \
           src/primitive/sphere.cpp \
           src/primitive/triangle.cpp \
           src/render-mode.cpp \
           src/renderer.cpp \
           src/scene.cpp \
           src/sculpt-brush.cpp \
           src/shader.cpp \
           src/sketch/bone-intersection.cpp \
           src/sketch/conversion.cpp \
           src/sketch/mesh.cpp \
           src/sketch/mesh-intersection.cpp \
           src/sketch/node-intersection.cpp \
           src/sketch/sphere.cpp \
           src/state.cpp \
           src/subdivision-butterfly.cpp \
           src/time-delta.cpp \
           src/tool.cpp \
           src/tool/convert-sketch.cpp \
           src/tool/delete-mesh.cpp \
           src/tool/delete-sketch-node.cpp \
           src/tool/modify-sketch.cpp \
           src/tool/move-mesh.cpp \
           src/tool/move-camera.cpp \
           src/tool/new-mesh.cpp \
           src/tool/new-sketch.cpp \
           src/tool/rebalance-sketch.cpp \
           src/tool/sculpt.cpp \
           src/tool/sculpt/carve.cpp \
           src/tool/sculpt/crease.cpp \
           src/tool/sculpt/drag.cpp \
           src/tool/sculpt/flatten.cpp \
           src/tool/sculpt/grab.cpp \
           src/tool/sculpt/pinch.cpp \
           src/tool/sculpt/reduce.cpp \
           src/tool/sculpt/smooth.cpp \
           src/tool/sketch-spheres.cpp \
           src/tool/util/movement.cpp \
           src/tool/util/scaling.cpp \
           src/util.cpp \
           src/view/axis.cpp \
           src/view/cursor.cpp \
           src/view/double-slider.cpp \
           src/view/gl-widget.cpp \
           src/view/light.cpp \
           src/view/main-widget.cpp \
           src/view/main-window.cpp \
           src/view/menu-bar.cpp \
           src/view/properties.cpp \
           src/view/tool-tip.cpp \
           src/view/util.cpp \
           src/winged/edge.cpp \
           src/winged/face.cpp \
           src/winged/face-intersection.cpp \
           src/winged/mesh.cpp \
           src/winged/util.cpp \
           src/winged/vertex.cpp \
           src/xml-conversion.cpp \

HEADERS += \
           src/action/finalize.hpp \
           src/action/sculpt.hpp \
           src/action/subdivide-mesh.hpp \
           src/adjacent-iterator.hpp \
           src/affected-faces.hpp \
           src/bitset.hpp \
           src/cache.hpp \
           src/camera.hpp \
           src/color.hpp \
           src/config.hpp \
           src/configurable.hpp \
           src/dimension.hpp \
           src/hash.hpp \
           src/history.hpp \
           src/index-octree.hpp \
           src/intersection.hpp \
           src/intrusive-list.hpp \
           src/kvstore.hpp \
           src/macro.hpp \
           src/maybe.hpp \
           src/mesh.hpp \
           src/mesh-util.hpp \
           src/mirror.hpp \
           src/opengl.hpp \
           src/opengl-buffer-id.hpp \
           src/partial-action/collapse-edge.hpp \
           src/partial-action/collapse-face.hpp \
           src/partial-action/delete-edge-face.hpp \
           src/partial-action/delete-valence-3-vertex.hpp \
           src/partial-action/delete-vertex.hpp \
           src/partial-action/flip-edge.hpp \
           src/partial-action/insert-edge-face.hpp \
           src/partial-action/insert-edge-vertex.hpp \
           src/partial-action/relax-edge.hpp \
           src/partial-action/smooth.hpp \
           src/partial-action/subdivide-edge.hpp \
           src/partial-action/triangulate-6-gon.hpp \
           src/partial-action/triangulate-quad.hpp \
           src/primitive/aabox.hpp \
           src/primitive/cone.hpp \
           src/primitive/cylinder.hpp \
           src/primitive/plane.hpp \
           src/primitive/ray.hpp \
           src/primitive/sphere.hpp \
           src/primitive/triangle.hpp \
           src/render-mode.hpp \
           src/renderer.hpp \
           src/scene.hpp \
           src/sculpt-brush.hpp \
           src/shader.hpp \
           src/sketch/bone-intersection.hpp \
           src/sketch/conversion.hpp \
           src/sketch/fwd.hpp \
           src/sketch/mesh.hpp \
           src/sketch/mesh-intersection.hpp \
           src/sketch/node-intersection.hpp \
           src/sketch/sphere.hpp \
           src/state.hpp \
           src/subdivision-butterfly.hpp \
           src/time-delta.hpp \
           src/tool.hpp \
           src/tool/move-camera.hpp \
           src/tool/sculpt.hpp \
           src/tool/util/movement.hpp \
           src/tool/util/scaling.hpp \
           src/tools.hpp \
           src/tree.hpp \
           src/util.hpp \
           src/variant.hpp \
           src/view/axis.hpp \
           src/view/cursor.hpp \
           src/view/double-slider.hpp \
           src/view/gl-widget.hpp \
           src/view/light.hpp \
           src/view/main-widget.hpp \
           src/view/main-window.hpp \
           src/view/menu-bar.hpp \
           src/view/properties.hpp \
           src/view/tool-tip.hpp \
           src/view/util.hpp \
           src/winged/edge.hpp \
           src/winged/face.hpp \
           src/winged/face-intersection.hpp \
           src/winged/fwd.hpp \
           src/winged/mesh.hpp \
           src/winged/util.hpp \
           src/winged/vertex.hpp \
           src/xml-conversion.hpp \
