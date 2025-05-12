#-------------------------------------------------------------------------------
#  vertexpull.nim
#
#  Pull vertices from a storage buffer instead of using fixed-function
#  vertex input.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/vertexpull as shd

var
  pip: Pipeline
  bindings: Bindings
  passAction: PassAction
  rx: float32 = 0
  ry: float32 = 0

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
      environment: sglue.environment(),
      logger: sg.Logger(fn: slog.fn),
  ))

  # if storage buffers are not supported on this backend, just render a red screen
  if not sg.queryFeatures().compute:
    passAction = sg.PassAction(
      colors: [
        ColorAttachmentAction(loadAction: loadActionClear, clearValue: (1, 0, 0, 1))
      ]
    )
  else:
    passAction = sg.PassAction(
      colors: [
        ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.75, 0.5, 0.25, 1 ))
      ]
    )

  # a storage buffer with cube vertex data using the code-generated SSBO struct
  # (looks a bit awkward in Nim, but that way the data is properly padded and aligned)
  const vertices = [
    shd.SbVertex(pos: [-1.0, -1.0, -1.0],  color: [1.0, 0.0, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0, -1.0],  color: [1.0, 0.0, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0, -1.0],  color: [1.0, 0.0, 0.0, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0, -1.0],  color: [1.0, 0.0, 0.0, 1.0]),
    shd.SbVertex(pos: [-1.0, -1.0,  1.0],  color: [0.0, 1.0, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0,  1.0],  color: [0.0, 1.0, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0,  1.0],  color: [0.0, 1.0, 0.0, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0,  1.0],  color: [0.0, 1.0, 0.0, 1.0]),
    shd.SbVertex(pos: [-1.0, -1.0, -1.0],  color: [0.0, 0.0, 1.0, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0, -1.0],  color: [0.0, 0.0, 1.0, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0,  1.0],  color: [0.0, 0.0, 1.0, 1.0]),
    shd.SbVertex(pos: [-1.0, -1.0,  1.0],  color: [0.0, 0.0, 1.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0, -1.0],  color: [1.0, 0.5, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0, -1.0],  color: [1.0, 0.5, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0,  1.0],  color: [1.0, 0.5, 0.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0,  1.0],  color: [1.0, 0.5, 0.0, 1.0]),
    shd.SbVertex(pos: [-1.0, -1.0, -1.0],  color: [0.0, 0.5, 1.0, 1.0]),
    shd.SbVertex(pos: [-1.0, -1.0,  1.0],  color: [0.0, 0.5, 1.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0,  1.0],  color: [0.0, 0.5, 1.0, 1.0]),
    shd.SbVertex(pos: [ 1.0, -1.0, -1.0],  color: [0.0, 0.5, 1.0, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0, -1.0],  color: [1.0, 0.0, 0.5, 1.0]),
    shd.SbVertex(pos: [-1.0,  1.0,  1.0],  color: [1.0, 0.0, 0.5, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0,  1.0],  color: [1.0, 0.0, 0.5, 1.0]),
    shd.SbVertex(pos: [ 1.0,  1.0, -1.0],  color: [1.0, 0.0, 0.5, 1.0]),
  ]
  bindings.storageBuffers[shd.sbufSsbo] = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(storageBuffer: true),
    data: sg.Range(addr: vertices.addr, size: vertices.sizeof)
  ))

  # a regular index buffer
  const indices = [
    0'u16, 1, 2,  0, 2, 3,
    6, 5, 4,      7, 6, 4,
    8, 9, 10,     8, 10, 11,
    14, 13, 12,   15, 14, 12,
    16, 17, 18,   16, 18, 19,
    22, 21, 20,   23, 22, 20,
  ]
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(indexBuffer: true),
    data: sg.Range(addr: indices.addr, size: indices.sizeof)
  ))

  # a pipeline object, note that there's not vertex layout, since we're
  # not using the fixed-function vertex input
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.vertexpullShaderDesc(sg.queryBackend())),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    )
  ))

proc computeVsParams(): shd.VsParams =
  let proj = persp(60.0f, sapp.widthf()/sapp.heightf(), 0.01f, 10.0f)
  let view = lookat(vec3(0.0f, 1.5f, 6.0f), vec3.zero(), vec3.up())
  let rxm = rotate(rx, vec3(1f, 0f, 0f))
  let rym = rotate(ry, vec3(0f, 1f, 0f))
  let model = rxm * rym
  result = VsParams(mvp: proj * view * model)

proc frame() {.cdecl.} =
  let dt = sapp.frameDuration() * 60f
  rx += 1f * dt
  ry += 2f * dt
  let vsParams = computeVsParams();

  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  if sg.queryFeatures().compute:
    sg.applyPipeline(pip)
    sg.applyBindings(bindings)
    sg.applyUniforms(shd.ubVsParams, sg.Range(addr: vsParams.addr, size: vsParams.sizeof))
    sg.draw(0, 36, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  windowTitle: "vertexpull.nim",
  width: 800,
  height: 600,
  sampleCount: 4,
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn)
))
