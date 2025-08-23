#-------------------------------------------------------------------------------
# instancingcompute.nim
#
# Like instancing.nim but updating particle positions in a compute shader.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/instancingcompute as shd

const
  maxParticles = 512 * 1024
  numParticlesEmittedPerFrame = 10

var
  numParticles: int32
  ry: float32
  computePipeline: Pipeline
  computeBindings: Bindings
  displayPipeline: Pipeline
  displayBindings: Bindings
  displayPassAction: PassAction

proc init() {.cdecl} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # if compute shaders not supported, clear to red and early-out
  if not sg.queryFeatures().compute:
    displayPassAction = PassAction(
      colors: [ ColorAttachmentAction( loadAction: loadActionClear, clearValue: (1, 0, 0, 1)) ]
    )

  # regular clear color
  displayPassAction = PassAction(
    colors: [ ColorAttachmentAction( loadAction: loadActionClear, clearValue: (0, 0.1, 0.2, 1)) ]
  )

  # a buffer and storage-buffer-view for the particle state
  let sbuf = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(storageBuffer: true),
    size: maxParticles * Particle.sizeof,
    label: "particle-buffer",
  ))
  let sbufView: View = sg.makeView(ViewDesc(
    storageBuffer: BufferViewDesc(buffer: sbuf)
  ))
  computeBindings.views[viewCsSsbo] = sbufView
  displayBindings.views[viewVsSsbo] = sbufView

  # a compute shader and pipeline object for updating the particle state
  computePipeline = sg.makePipeline(PipelineDesc(
    compute: true,
    shader: sg.makeShader(updateShaderDesc(sg.queryBackend())),
    label: "compute-pipeline"
  ))

  # vertex and index buffer for the particle geometry
  const r = 0.05f
  const vertices = [
    # positions             colors
    0.0f,   -r, 0.0f,       1.0f, 0.0f, 0.0f, 1.0f,
       r, 0.0f,  r,         0.0f, 1.0f, 0.0f, 1.0f,
       r, 0.0f, -r,         0.0f, 0.0f, 1.0f, 1.0f,
      -r, 0.0f, -r,         1.0f, 1.0f, 0.0f, 1.0f,
      -r, 0.0f, r,          0.0f, 1.0f, 1.0f, 1.0f,
    0.0f,    r, 0.0f,       1.0f, 0.0f, 1.0f, 1.0f
  ]
  displayBindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.addr, size: vertices.sizeof),
    label: "geometry-vbuf",
  ))
  const indices = [
    0'u16, 1, 2,  0, 2, 3,    0, 3, 4,    0, 4, 1,
    5, 1, 2,      5, 2, 3,    5, 3, 4,    5, 4, 1
  ]
  displayBindings.indexBuffer = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(indexBuffer: true),
    data: sg.Range(addr: indices.addr, size: indices.sizeof),
    label: "geometry-ibuf",
  ))

  # shader and pipeline for rendering the particles, this uses
  # the compute-updated storage buffer to provide the particle positions
  displayPipeline = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(displayShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      attrs: [
        VertexAttrState(format: vertexFormatFloat3),  # pos
        VertexAttrState(format: vertexFormatFloat4),  # color0
      ],
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    ),
    label: "render-pipeline",
  ))

  # one-time init of particle velocities via compute shader
  let pip = sg.makePipeline(PipelineDesc(
    compute: true,
    shader: sg.makeShader(initShaderDesc(sg.queryBackend())),
  ))
  sg.beginPass(Pass(compute: true))
  sg.applyPipeline(pip)
  sg.applyBindings(computeBindings)
  sg.dispatch((maxParticles / 64).int32, 1, 1)
  sg.endPass()
  sg.destroyPipeline(pip)

proc drawFallback() =
  sg.beginPass(Pass(action: displayPassAction, swapchain: sglue.swapchain(), label: "render-pass"))
  sg.endPass()
  sg.commit()

proc computeVsParams(): VsParams =
  let proj = persp(60, sapp.widthf() / sapp.heightf(), 0.01, 50.0)
  let view = lookat(vec3(0, 1.5, 12), vec3.zero(), vec3.up())
  let model = rotate(ry, vec3.up())
  return VsParams(mvp: proj * view * model)

proc frame() {.cdecl} =
  if not sg.queryFeatures().compute:
    drawFallback()
    return

  numParticles += numParticlesEmittedPerFrame;
  if numParticles > maxParticles:
    numParticles = maxParticles
  let dt: float32 = sapp.frameDuration()

  # compute pass to update particle positions
  let csParams = CsParams(dt: dt, num_particles: num_particles)
  sg.beginPass(Pass(compute: true, label: "compute-pass"))
  sg.applyPipeline(computePipeline)
  sg.applyBindings(computeBindings)
  sg.applyUniforms(ubCsParams, sg.Range(addr: csParams.addr, size: csParams.sizeof))
  sg.dispatch(((numParticles + 63) / 64).int32, 1, 1)
  sg.endPass()

  # shader and pipeline for rendering the particles, this uses the
  # compute-updated storage buffer to provide the particle positions
  ry += 60.0 * dt
  let vsParams = computeVsParams()
  sg.beginPass(Pass(action: displayPassAction, swapchain: sglue.swapchain(), label: "render-pass"))
  sg.applyPipeline(displayPipeline)
  sg.applyBindings(displayBindings)
  sg.applyUniforms(ubVsParams, sg.Range(addr: vsParams.addr, size: vsParams.sizeof))
  sg.draw(0, 24, num_particles)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 800,
  height: 600,
  sampleCount: 4,
  windowTitle: "instancingcompute.nim",
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
