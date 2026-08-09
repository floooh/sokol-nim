#-------------------------------------------------------------------------------
#   bufferoffsets.zig
#   Render separate geometries in vertex- and index-buffers with
#   buffer offsets.
#-------------------------------------------------------------------------------
import sokol/log as slog
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
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # clear to a blue-ish color
  var ca = ColorAttachmentAction(loadAction: loadActionClear, storeAction: storeActionStore, clearValue: Color(r: 0.5f32, g: 0.5f32, b: 1.0f32, a: 1.0f32))
  passAction.colors[0] = ca

  # a 2D triangle and quad in one vertex buffer and one index buffer
  const vertices = [
    # triangle vertices
    Vertex(x:  0.0'f32,  y: 0.55'f32,  r: 1.0'f32, g: 0.0'f32, b: 0.0'f32),
    Vertex(x:  0.25'f32, y: 0.05'f32,  r: 0.0'f32, g: 1.0'f32, b: 0.0'f32),
    Vertex(x: -0.25'f32, y: 0.05'f32,  r: 0.0'f32, g: 0.0'f32, b: 1.0'f32),

    # quad vertices
    Vertex(x: -0.25'f32, y: -0.05'f32,  r: 0.0'f32, g: 0.0'f32, b: 1.0'f32),
    Vertex(x:  0.25'f32, y: -0.05'f32,  r: 0.0'f32, g: 1.0'f32, b: 0.0'f32),
    Vertex(x:  0.25'f32, y: -0.55'f32,  r: 1.0'f32, g: 0.0'f32, b: 0.0'f32),
    Vertex(x: -0.25'f32, y: -0.55'f32,  r: 1.0'f32, g: 1.0'f32, b: 0.0'f32)
  ]
  const indices = [
    # triangle indices
    0'u16, 1, 2,
    # quad indices
    0, 1, 2, 0, 2, 3
  ]
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.addr, size: vertices.sizeof)
  ))
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(indexBuffer: true),
    data: sg.Range(addr: indices.addr, size: indices.sizeof)
  ))

  # shader and pipeline object
  var attrs = default(array[0..15, VertexAttrState])
  attrs[0] = VertexAttrState(format: vertexFormatFloat2)
  attrs[1] = VertexAttrState(format: vertexFormatFloat3)
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.bufferoffsetsShaderDesc(sg.queryBackend())),
    indexType: indexTypeUint16,
    layout: VertexLayoutState(
      attrs: attrs
    )
  ))

proc frame() {.cdecl.} =
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  sg.applyPipeline(pip)
  # render the triangle
  bindings.vertexBufferOffsets[0] = 0
  bindings.indexBufferOffset = 0
  sg.applyBindings(bindings)
  sg.draw(0, 3, 1)
  #render the quad
  bindings.vertexBufferOffsets[0] = (3 * sizeof(Vertex)).int32
  bindings.indexBufferOffset = (3 * sizeof(uint16)).int32
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
  windowTitle: "bufferoffsets.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
