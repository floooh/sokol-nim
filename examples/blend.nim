#-------------------------------------------------------------------------------
# blend.nim
# Test/demonstrate blend modes.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as glue
import std/math
import math/Vec3
import math/Mat4
import shaders/blend as shd

import typetraits

const numBlendFactors = 15

var
  bgPip: Pipeline
  pip: array[numBlendFactors, array[numBlendFactors, Pipeline]]
  bindings: Bindings
  r = 0f
  tick = 0f

const passAction = PassAction(
  colors: [ColorAttachmentAction(action: Action.dontCare)],
  depth: DepthAttachmentAction(action: Action.dontCare),
  stencil: StencilAttachmentAction(action: Action.dontCare),
)

proc init() {.cdecl.} =
  echo numBlendFactors.type.name
  sg.setup(sg.Desc(
      pipelinePoolSize: numBlendFactors * numBlendFactors + 1,
      context:context(),
    ))

  # quad vertex buffer
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
      type: BufferType.vertexBuffer,
      data: [
        # position             color0
        -1.0f, -1.0f, 0.0f,    1.0f, 0.0f, 0.0f, 0.5f,
        +1.0f, -1.0f, 0.0f,    0.0f, 1.0f, 0.0f, 0.5f,
        -1.0f, +1.0f, 0.0f,    0.0f, 0.0f, 1.0f, 0.5f,
        +1.0f, +1.0f, 0.0f,    1.0f, 1.0f, 0.0f, 0.5f
      ],
    ))

  # pipeline object for rendering the background
  bgPip = sg.makePipeline(PipelineDesc(
    layout: LayoutDesc(
      buffers: [ BufferLayoutDesc(stride: 28) ],
      attrs: [ VertexAttrDesc(offset: 0, format: VertexFormat.float2 )]
    ),
    shader: sg.makeShader(shd.bgShaderDesc(sg.queryBackend())),
    primitiveType: PrimitiveType.triangleStrip,
  ))

  # lot of pipeline objects for rendering the blended quads
  var pipDesc = PipelineDesc(
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: VertexFormat.float3),
        VertexAttrDesc(format: VertexFormat.float4)
      ]
    ),
    shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
    primitiveType: PrimitiveType.triangleStrip,
    blendColor: (1.0, 0.0, 0.0, 1.0),
    colors: [
      ColorState(blend: BlendState(enabled: true, srcFactorAlpha: BlendFactor.one, dstFactorAlpha: BlendFactor.zero))
    ]
  )
  for src in 0..<numBlendFactors:
    for dst in 0..<numBlendFactors:
      pipDesc.colors[0].blend.srcFactorRgb = (src+1).BlendFactor
      pipDesc.colors[0].blend.dstFactorRgb = (dst+1).BlendFactor
      pip[src][dst] = sg.makePipeline(pipDesc)

proc frame() {.cdecl.} =
  let time = sapp.frameDuration() * 60.0

  sg.beginDefaultPass(passAction, sapp.width(), sapp.height());

  # draw background
  tick += 1.0 * time;
  sg.applyPipeline(bgPip);
  sg.applyBindings(bindings);
  sg.applyUniforms(ShaderStage.fs, shd.slotBgFsParams, BgFsParams(tick: tick));
  sg.draw(0, 4, 1);

  # draw the blended quads
  let proj = persp(90f, sapp.widthf() / sapp.heightf(), 0.01f, 100f);
  let view = lookat(vec3(0f, 0f, 25f), vec3.zero(), vec3.up());
  let viewProj = proj * view;

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
      sg.applyPipeline(pip[src][dst])
      sg.applyBindings(bindings)
      sg.applyUniforms(ShaderStage.vs, shd.slotQuadVsParams, QuadVsParams(mvp: viewProj * model))
      sg.draw(0, 4, 1)
      r0 += 0.6
  sg.endPass();
  sg.commit();

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
))
