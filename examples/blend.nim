#-------------------------------------------------------------------------------
# blend.nim
# Test/demonstrate blend modes.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import std/math
import math/vec3
import math/mat4
import shaders/blend as shd

const numBlendFactors = 15

var
  bgPip: Pipeline
  pip: array[numBlendFactors, array[numBlendFactors, Pipeline]]
  bindings: Bindings
  r = 0f
  tick = 0f

const passAction = PassAction(
  colors: [ColorAttachmentAction(loadAction: loadActionDontCare)],
  depth: DepthAttachmentAction(loadAction: loadActionDontCare),
  stencil: StencilAttachmentAction(loadAction: loadActionDontCare),
)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
      pipelinePoolSize: numBlendFactors * numBlendFactors + 1,
      environment: sglue.environment(),
      logger: sg.Logger(fn: slog.fn),
    ))

  # quad vertex buffer
  const vertices = [
    # position             color0
    -1.0f, -1.0f, 0.0f,    1.0f, 0.0f, 0.0f, 0.5f,
    +1.0f, -1.0f, 0.0f,    0.0f, 1.0f, 0.0f, 0.5f,
    -1.0f, +1.0f, 0.0f,    0.0f, 0.0f, 1.0f, 0.5f,
    +1.0f, +1.0f, 0.0f,    1.0f, 1.0f, 0.0f, 0.5f
  ]
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
      type: bufferTypeVertexBuffer,
      data: sg.Range(addr: vertices.addr, size: vertices.sizeof)
    ))

  # pipeline object for rendering the background
  bgPip = sg.makePipeline(PipelineDesc(
    layout: VertexLayoutState(
      buffers: [ VertexBufferLayoutState(stride: 28) ],
      attrs: [ VertexAttrState(offset: 0, format: vertexFormatFloat2 )]
    ),
    shader: sg.makeShader(shd.bgShaderDesc(sg.queryBackend())),
    primitiveType: primitiveTypeTriangleStrip,
  ))

  # lot of pipeline objects for rendering the blended quads
  var pipDesc = PipelineDesc(
    layout: VertexLayoutState(
      attrs: [
        VertexAttrState(format: vertexFormatFloat3),
        VertexAttrState(format: vertexFormatFloat4)
      ]
    ),
    shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
    primitiveType: primitiveTypeTriangleStrip,
    blendColor: (1.0, 0.0, 0.0, 1.0),
    colors: [
      ColorTargetState(blend: BlendState(enabled: true, srcFactorAlpha: blendFactorOne, dstFactorAlpha: blendFactorZero))
    ]
  )
  for src in 0..<numBlendFactors:
    for dst in 0..<numBlendFactors:
      pipDesc.colors[0].blend.srcFactorRgb = (src+1).BlendFactor
      pipDesc.colors[0].blend.dstFactorRgb = (dst+1).BlendFactor
      pip[src][dst] = sg.makePipeline(pipDesc)

proc frame() {.cdecl.} =
  let time = sapp.frameDuration() * 60.0

  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))

  # draw background
  let bgFsParams = BgFsParams(tick: tick)
  tick += 1.0 * time
  sg.applyPipeline(bgPip)
  sg.applyBindings(bindings)
  sg.applyUniforms(shaderStageFs, shd.slotBgFsParams, sg.Range(addr: bgFsParams.addr, size: bgFsParams.sizeof))
  sg.draw(0, 4, 1)

  # draw the blended quads
  let proj = persp(90f, sapp.widthf() / sapp.heightf(), 0.01f, 100f)
  let view = lookat(vec3(0f, 0f, 25f), vec3.zero(), vec3.up())
  let viewProj = proj * view

  r += 0.6 * time
  var r0 = r
  for src in 0..<numBlendFactors:
    for dst in 0..<numBlendFactors:
      # compute model-view-proj matrix
      let t = vec3(
        (dst.float32 - trunc(numBlendFactors/2)) * 3.0,
        (src.float32 - trunc(numBlendFactors/2)) * 2.2,
        0f
      )
      let model = translate(t) * rotate(r0, vec3.up())
      let quadVsParams = QuadVsParams(mvp: viewProj * model)
      sg.applyPipeline(pip[src][dst])
      sg.applyBindings(bindings)
      sg.applyUniforms(shaderStageVs, shd.slotQuadVsParams, sg.Range(addr: quadVsParams.addr, size: quadVsParams.sizeof))
      sg.draw(0, 4, 1)
      r0 += 0.6
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  windowTitle: "blend.nim",
  width: 800,
  height: 600,
  sampleCount: 4,
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
