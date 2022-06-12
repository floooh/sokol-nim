#-------------------------------------------------------------------------------
# blend.nim
# Test/demonstrate blend modes.
#-------------------------------------------------------------------------------

import glm
import sokol/[app,gfx,glue]
from blend_data import
  quadVertices, quadVertexShader, quadFragmentShader,
  bgVertexShader, bgFragmentShader

const numBlendFactors = 15

type VsUniforms = object
  mvp: Mat4f

type FsUniforms = object
  tick: float32

var bgPipeline: Pipeline
var pipelines: array[numBlendFactors, array[numBlendFactors, Pipeline]]
var bindings: Bindings

var vsUniforms = VsUniforms()
var fsUniforms = FsUniforms()
var r = 0f

# pass action does not clear because the entire screen will be overwritten
const passAction = PassAction(
  colors: [ColorAttachmentAction(action: Action.dontCare)],
  depth: DepthAttachmentAction(action: Action.dontCare),
  stencil: StencilAttachmentAction(action: Action.dontCare),
)

proc init() {.cdecl.} =
  setup(
    gfx.Desc(
      context:context(),
      pipelinePoolSize: numBlendFactors * numBlendFactors + 1,
    )
  )

  # quad vertex buffer
  let vbuf = makeBuffer(
    BufferDesc(
      type: BufferType.vertexBuffer,
      data: quadVertices,
      label: "quad-vertices",
    )
  )

  let bgShader = makeShader(
    ShaderDesc(
      attrs:[
        ShaderAttrDesc(semName: "POS")
      ],
      vs: ShaderStageDesc(
        source: bgVertexShader
      ),
      fs: ShaderStageDesc(
        uniformBlocks: [
          ShaderUniformBlockDesc(
            size: FsUniforms.sizeof.uint,
            uniforms: [
              ShaderUniformDesc(name: "tick", type: UniformType.float),
            ],
          ),
        ],
        source: bgFragmentShader
      )
    )
  )

  bgPipeline = makePipeline(
    PipelineDesc(
      layout: LayoutDesc(
        buffers: [
          BufferLayoutDesc(stride: 28),
        ],
        attrs: [
          VertexAttrDesc(offset: 0, format: VertexFormat.float2),
        ],
      ),
      shader: bgShader,
      primitiveType: PrimitiveType.triangleStrip,
      label: "bgPipeline",
    )
  )

  let quadShader = makeShader(
    ShaderDesc(
      attrs: [
        ShaderAttrDesc(semName: "POS"),
        ShaderAttrDesc(semName: "COLOR")
      ],
      vs: ShaderStageDesc(
        uniformBlocks: [
          ShaderUniformBlockDesc(
            size: VsUniforms.sizeof.uint,
            uniforms: [
              ShaderUniformDesc(name: "mvp", type: UniformType.mat4),
            ],
          ),
        ],
        source: quadVertexShader
      ),
      fs: ShaderStageDesc(
        source: quadFragmentShader
      )
    )
  )

  block:
    var pipelineDesc = PipelineDesc(
      layout:LayoutDesc(
          attrs:[
              VertexAttrDesc(offset: 0,  format: VertexFormat.float3),
              VertexAttrDesc(offset: 12, format: VertexFormat.float4),
          ],
      ),
      shader: quadShader,
      primitiveType: PrimitiveType.triangleStrip,
      colors: [
        ColorState(
          blend: BlendState(
            enabled: true,
            srcFactorAlpha: BlendFactor.one,
            dstFactorAlpha: BlendFactor.zero,
          ),
        ),
      ],
      blendColor:(1f, 0f, 0f, 1f),
    )
    for src in 0..<numBlendFactors:
      for dst in 0..<numBlendFactors:
        pipelineDesc.colors[0].blend.srcFactorRgb = (src+1).BlendFactor
        pipelineDesc.colors[0].blend.dstFactorRgb = (dst+1).BlendFactor
        pipelines[src][dst] = makePipeline(pipelineDesc)

  bindings = Bindings(
    vertexBuffers:[vbuf],
  )

proc frame() {.cdecl.} =
  let proj = perspective(radians(60f), app.widthf()/app.heightf(), 0.01f, 100f)
  let view = lookAt(vec3(0f, 0f, 25f), vec3(0f, 0f, 0f), vec3(0f, 1f, 0f))
  let viewProj = proj * view;

  beginDefaultPass(passAction, app.width(), app.height())

  # the background quad
  applyPipeline(bgPipeline)
  applyBindings(bindings)
  applyUniforms(ShaderStage.fs, 0, fsUniforms)
  draw(0, 4, 1)

  # the blended quads
  var r0 = r
  for src in 0..<numBlendFactors:
    for dst in 0..<numBlendFactors:
      r0 += 0.06f
      let rm = rotate(mat4(1.0f), r0, 0.0f, 1.0f, 0.0f)
      let x = (dst.float32 - numBlendFactors/2) * 3.0f
      let y = (src.float32 - numBlendFactors/2) * 2.2f
      let model = translate(mat4(1.0f), x, y, 0.0f) * rm
      vsUniforms.mvp = viewProj * model
      applyPipeline(pipelines[src][dst])
      applyBindings(bindings)
      applyUniforms(ShaderStage.vs, 0, vsUniforms)
      draw(0, 4, 1)

  endPass()
  commit()
  r += 0.06f
  fsUniforms.tick += 1f

proc cleanup() {.cdecl.} =
  shutdown()

proc fail(reason: cstring) {.cdecl.} =
  echo "sokol error: ", reason

app.run(app.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  failCb: fail,
  windowTitle: "blend.nim",
  width: 640,
  height: 480,
))
