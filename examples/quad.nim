#-------------------------------------------------------------------------------
#   quad.zig
#   Simple 2D rendering with vertex- and index-buffer.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as glue
import shaders/quad as shd

var
  pip: Pipeline
  bindings: Bindings
  passAction: PassAction

proc init() {.cdecl.} =
  sg.setup(sg.Desc( context: glue.context() ))

  # a vertex buffer
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: [
      # positions         colors
      -0.5'f32, 0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
       0.5, 0.5, 0.5,     0.0, 1.0, 0.0, 1.0,
       0.5, -0.5, 0.5,    0.0, 0.0, 1.0, 1.0,
      -0.5, -0.5, 0.5,    1.0, 1.0, 0.0, 1.0
    ]
  ))

  # an index buffer
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: BufferType.indexBuffer,
    data: [ 0'u16, 1, 2, 0, 2, 3 ]
  ))

  # a shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: VertexFormat.float3),
        VertexAttrDesc(format: VertexFormat.float4)
      ],
    ),
    indexType: IndexType.uint16
  ))

  # pass action for clearing to black
  passAction.colors[0] = ColorAttachmentAction( action: Action.clear, value: (0f, 0f, 0f, 1f))

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
  window_title: "quad.nim"
))
