#-------------------------------------------------------------------------------
#   quad.zig
#   Simple 2D rendering with vertex- and index-buffer.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import shaders/quad as shd

var
  pip: Pipeline
  bindings: Bindings
  passAction: PassAction

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))

  # a vertex buffer
  let vertices = [
    # positions         colors
    -0.5'f32, 0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
     0.5, 0.5, 0.5,     0.0, 1.0, 0.0, 1.0,
     0.5, -0.5, 0.5,    0.0, 0.0, 1.0, 1.0,
    -0.5, -0.5, 0.5,    1.0, 1.0, 0.0, 1.0
  ]
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.unsafeAddr, size: vertices.sizeof)
  ))

  # an index buffer
  const indices = [ 0'u16, 1, 2, 0, 2, 3 ]
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: bufferTypeIndexBuffer,
    data: sg.Range(addr: indices.unsafeAddr, size: indices.sizeof)
  ))

  # a shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: vertexFormatFloat3),
        VertexAttrDesc(format: vertexFormatFloat4)
      ],
    ),
    indexType: indexTypeUint16
  ))

  # pass action for clearing to black
  passAction.colors[0] = ColorAttachmentAction( action: actionClear, value: (0f, 0f, 0f, 1f))

proc frame() {.cdecl.} =
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.draw(0, 6, 1)
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
  window_title: "quad.nim",
  icon: IconDesc(sokol_default: true)
))
