#-------------------------------------------------------------------------------
#   triangle.nim
#   Vertex buffer, shader, pipeline state object.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import shaders/triangle as shd

var
  pip: Pipeline
  bindings: Bindings

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # create vertex buffer with triangle vertices
  const vertices = [
    # positions          colors
     0.0'f32,  0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
     0.5, -0.5, 0.5,     0.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, 0.5,     0.0, 0.0, 1.0, 1.0
  ]
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.addr, size: vertices.sizeof)
  ))

  # create shader and pipeline object
  pip = sg.makePipeline:
    var pd = PipelineDesc(
      shader: sg.makeShader(shd.triangleShaderDesc(sg.queryBackend()))
    )
    pd.layout.attrs[0] = VertexAttrState(format: vertexFormatFloat3)
    pd.layout.attrs[1] = VertexAttrState(format: vertexFormatFloat4)
    pd

proc frame() {.cdecl.} =
  # default PassAction clears to grey
  sg.beginPass(Pass(swapchain: sglue.swapchain()))
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
  windowTitle: "triangle.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
