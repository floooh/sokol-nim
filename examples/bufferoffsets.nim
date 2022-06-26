#-------------------------------------------------------------------------------
#   bufferoffsets.zig
#   Render separate geometries in vertex- and index-buffers with
#   buffer offsets.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import shaders/bufferoffsets as shd

var
  passAction: PassAction
  pip: Pipeline
  bindings: Bindings

type Vertex = object
  x, y: float32
  r, g, b: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))

  # clear to a blue-ish color
  passAction.colors[0] = ColorAttachmentAction( action: actionClear, value: (0.5, 0.5, 1.0, 1.0))

  # a 2D triangle and quad in one vertex buffer and one index buffer
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: [
      # triangle vertices
      Vertex(x:  0.0,  y: 0.55,  r: 1.0, g: 0.0, b: 0.0),
      Vertex(x:  0.25, y: 0.05,  r: 0.0, g: 1.0, b: 0.0),
      Vertex(x: -0.25, y: 0.05,  r: 0.0, g: 0.0, b: 1.0),

      # quad vertices
      Vertex(x: -0.25, y: -0.05,  r: 0.0, g: 0.0, b: 1.0),
      Vertex(x:  0.25, y: -0.05,  r: 0.0, g: 1.0, b: 0.0),
      Vertex(x:  0.25, y: -0.55,  r: 1.0, g: 0.0, b: 0.0),
      Vertex(x: -0.25, y: -0.55,  r: 1.0, g: 1.0, b: 0.0)
    ]
  ))
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: bufferTypeIndexBuffer,
    data: [
      # triangle indices
      0'u16, 1, 2,
      # quad indices
      0, 1, 2, 0, 2, 3
    ]
  ))

  # shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.bufferoffsetsShaderDesc(sg.queryBackend())),
    indexType: indexTypeUint16,
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: vertexFormatFloat2),
        VertexAttrDesc(format: vertexFormatFloat3)
      ]
    )
  ))

proc frame() {.cdecl.} =
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  # render the triangle
  bindings.vertexBufferOffsets[0] = 0
  bindings.indexBufferOffset = 0
  sg.applyBindings(bindings)
  sg.draw(0, 3, 1)
  #render the quad
  bindings.vertexBufferOffsets[0] = 3 * sizeof(Vertex)
  bindings.indexBufferOffset = 3 * sizeof(uint16)
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
  width: 800,
  height: 600,
  windowTitle: "bufferoffsets.nim"
))
