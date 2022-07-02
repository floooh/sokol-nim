#-------------------------------------------------------------------------------
#   triangle.nim
#   Vertex buffer, shader, pipeline state object.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import shaders/triangle as shd

var
  pip: Pipeline
  bindings: Bindings

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))

  # create vertex buffer with triangle vertices
  const vertices = [
    # positions          colors
     0.0'f32,  0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
     0.5, -0.5, 0.5,     0.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, 0.5,     0.0, 0.0, 1.0, 1.0
  ]
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.unsafeAddr, size: vertices.sizeof)
  ))

  # create shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.triangleShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: vertexFormatFloat3),
        VertexAttrDesc(format: vertexFormatFloat4)
      ]
    )
  ))

proc frame() {.cdecl.} =
  # default PassAction clears to grey
  sg.beginDefaultPass(PassAction(), sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.draw(0, 3, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 640,
  height: 480,
  window_title: "triangle.nim",
  icon: IconDesc(sokol_default: true)
))
