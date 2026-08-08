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

const numBlendFactors = 15i32

var
  bgPip: Pipeline
  pip: array[numBlendFactors, array[numBlendFactors, Pipeline]]
  bindings: Bindings
  r = 0f
  tick = 0f

let passAction = block:
  var temp = PassAction(
   depth: DepthAttachmentAction(loadAction: loadActionDontCare),
   stencil: StencilAttachmentAction(loadAction: loadActionDontCare),
  )
  temp.colors[0] = ColorAttachmentAction(loadAction: loadActionDontCare)
  temp

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
      pipelinePoolSize: int32(numBlendFactors * numBlendFactors + 1),
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
      usage: BufferUsage(vertexBuffer: true),
      data: sg.Range(addr: vertices.addr, size: vertices.sizeof)
    ))

  # pipeline object for rendering the background
  bgPip = sg.makePipeline(PipelineDesc(
    layout: block:
      var l = VertexLayoutState()
      l.buffers[0] = VertexBufferLayoutState(stride: 28)
      l.attrs[0] = VertexAttrState(offset: 0, format: vertexFormatFloat2)
      l,
    shader: sg.makeShader(shd.bgShaderDesc(sg.queryBackend())),
    primitiveType: primitiveTypeTriangleStrip,
  ))

  # lot of pipeline objects for rendering the blended quads
  var pipDesc = PipelineDesc(
    layout: block:
      var l = VertexLayoutState()
      l.attrs[0] = VertexAttrState(format: vertexFormatFloat3)
      l.attrs[1] = VertexAttrState(format: vertexFormatFloat4)
      l,
    shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
    primitiveType: primitiveTypeTriangleStrip,
    blendColor: (1.0, 0.0, 0.0, 1.0),
    colors: block:
      var c: array[8, ColorTargetState] = default(array[8, ColorTargetState])
      c[0] = ColorTargetState(blend: BlendState(enabled: true, srcFactorAlpha: blendFactorOne, dstFactorAlpha: blendFactorZero))
      c
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
  tick += float32(1.0 * time)
  sg.applyPipeline(bgPip)
  sg.applyBindings(bindings)
  sg.applyUniforms(int32(shd.ubBgFsParams), sg.Range(addr: bgFsParams.addr, size: bgFsParams.sizeof.int))
  sg.draw(0, 4, 1)

  # draw the blended quads
  let proj = persp(90f, sapp.widthf() / sapp.heightf(), 0.01f, 100f)
  let view = lookat(vec3(0f, 0f, 25f), vec3.zero(), vec3.up())
  let viewProj: Mat4 = proj * view

  r += float32(0.6 * time)
  var r0 = r
  for src in 0..<numBlendFactors:
    for dst in 0..<numBlendFactors:
      # compute model-view-proj matrix
      let t = vec3(
        (dst.float32 - trunc(numBlendFactors.float32/2f)) * 3.0f32,
        (src.float32 - trunc(numBlendFactors.float32/2f)) * 2.2f32,
        0f
      )
      let model: Mat4 = translate(t) * rotate(r0, vec3.up())
      let quadVsParams = QuadVsParams(mvp: viewProj * model)
      sg.applyPipeline(pip[src][dst])
      sg.applyBindings(bindings)
      sg.applyUniforms(int32(shd.ubQuadVsParams), sg.Range(addr: quadVsParams.addr, size: quadVsParams.sizeof.int))
      sg.draw(0, 4, 1)
      r0 += 0.6.float32()
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
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
