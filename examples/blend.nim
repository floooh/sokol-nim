##------------------------------------------------------------------------------
##  blend.nim
##  Test/demonstrate blend modes.
##------------------------------------------------------------------------------
import glm
import sokol/[app,gfx]
import sugar

const NUM_BLEND_FACTORS = 15

gfx.setup(gfx.Desc(
  pipelinePoolSize: NUM_BLEND_FACTORS * NUM_BLEND_FACTORS + 1,
  context:app.gfxContext(),
))

app.cleanup = () => gfx.shutdown()

# app.event = (e:app.Event) => echo(e.type)

app.fail = (s:string) => echo("err: " & s)

# quad vertex buffer
var vertices = [
  # position             color0
  -1.0f, -1.0f, 0.0f,    1.0f, 0.0f, 0.0f, 0.5f,
  +1.0f, -1.0f, 0.0f,    0.0f, 1.0f, 0.0f, 0.5f,
  -1.0f, +1.0f, 0.0f,    0.0f, 0.0f, 1.0f, 0.5f,
  +1.0f, +1.0f, 0.0f,    1.0f, 1.0f, 0.0f, 0.5f
]
let vbuf = gfx.makeBuffer(gfx.BufferDesc(
  type:BufferType.VertexBuffer,
  data:vertices,
  label:"cube-vertices",
))
echo "sizeof(vertices):" & $sizeof(vertices)
echo "vbuf:" & $vbuf.id

type FsUniforms = object
  tick:float32

let bgShader = gfx.makeShader(ShaderDesc(
  vs:ShaderStageDesc(
    source:"""
      #version 330
      layout(location=0) in vec2 position;
      void main() {
          gl_Position = vec4(position, 0.5, 1.0);
      }
    """,
  ),
  fs:ShaderStageDesc(
    uniformBlocks:[
      ShaderUniformBlockDesc(
        size:sizeof(FsUniforms),
        uniforms:[
          ShaderUniformDesc(name:"tick", type:UniformType.Float),
        ],
      ),
    ],
    source:"""
      #version 330
      uniform float tick;
      out vec4 frag_color;
      void main() {
        vec2 xy = fract((gl_FragCoord.xy-vec2(tick)) / 50.0);
        frag_color = vec4(vec3(xy.x*xy.y), 1.0);
      }
    """,
  )
))

let bgPipeline = gfx.makePipeline(PipelineDesc(
  layout:LayoutDesc(
    buffers:[
      BufferLayoutDesc(stride:28),
    ],
    attrs:[
      VertexAttrDesc(offset:0, format:VertexFormat.Float2),
    ],
  ),
  shader:bgShader,
  primitiveType:PrimitiveType.TriangleStrip,
  label:"bgPipeline",
))

type VsUniforms = object
  mvp:Mat4f

let quadShader = gfx.makeShader(ShaderDesc(
  vs:ShaderStageDesc(
    uniformBlocks:[
      ShaderUniformBlockDesc(
        size:sizeof(VsUniforms),
        uniforms:[
          ShaderUniformDesc(name:"mvp", type:UniformType.Mat4),
        ],
      ),
    ],
    source:"""
      #version 330
      uniform mat4 mvp;
      in vec4 position;
      in vec4 color0;
      out vec4 color;
      void main() {
        gl_Position = mvp * position;
        color = color0;
      }
    """,
  ),
  fs:ShaderStageDesc(
    source:"""
      #version 330
      in vec4 color;
      out vec4 frag_color;
      void main() {
        frag_color = color;
      }
    """,
  )
))

var pipelines:array[NUM_BLEND_FACTORS, array[NUM_BLEND_FACTORS, Pipeline]]

block:
  var pipelineDesc = gfx.PipelineDesc(
    layout:LayoutDesc(
        attrs:[
            VertexAttrDesc(offset:0,  format:VertexFormat.Float3),
            VertexAttrDesc(offset:12, format:VertexFormat.Float4),
        ],
    ),
    shader:quadShader,
    primitiveType:PrimitiveType.TriangleStrip,
    colors:[
      ColorState(
        blend:BlendState(
          enabled:true,
          srcFactorAlpha:BlendFactor.One,
          dstFactorAlpha:BlendFactor.Zero,
        ),
      ),
    ],
    blendColor:(1f, 0f, 0f, 1f),
  )
  for src in 0..<NUM_BLEND_FACTORS:
    for dst in 0..<NUM_BLEND_FACTORS:
      pipelineDesc.colors[0].blend.srcFactorRgb = (src+1).BlendFactor
      pipelineDesc.colors[0].blend.dstFactorRgb = (dst+1).BlendFactor
      pipelines[src][dst] = makePipeline(pipelineDesc)

var bindings = gfx.Bindings(
  vertexBuffers:[vbuf],
)

# pass action does not clear because the entire screen will be overwritten
var passAction = gfx.PassAction(
  colors:[ColorAttachmentAction(action:Action.DontCare)],
  depth:DepthAttachmentAction(action:Action.DontCare),
  stencil:StencilAttachmentAction(action:Action.DontCare),
)

# a view-projection matrix
var vsUniforms = VsUniforms()
var fsUniforms = FsUniforms()
var r = 0f

app.frame = proc() =
  let proj = perspective(radians(60f), app.widthf()/app.heightf(), 0.01f, 100f)
  let view = lookAt(vec3(0f, 0f, 20f), vec3(0f, 0f, 0f), vec3(0f, 1f, 0f))
  let viewProj = proj * view;

  gfx.beginDefaultPass(passAction, app.width(), app.height())

  # the background quad
  gfx.applyPipeline(bgPipeline)
  gfx.applyBindings(bindings)
  gfx.applyUniforms(ShaderStage.Fragment, 0, fsUniforms)
  gfx.draw(0, 4, 1)

  # the blended quads
  var r0 = r
  for src in 0..<NUM_BLEND_FACTORS:
    for dst in 0..<NUM_BLEND_FACTORS:
      r0 += 0.06f
      let rm = rotate(mat4(1.0f), r0, 0.0f, 1.0f, 0.0f)
      let x = (dst.float32 - NUM_BLEND_FACTORS/2) * 3.0f
      let y = (src.float32 - NUM_BLEND_FACTORS/2) * 2.2f
      let model = translate(mat4(1.0f), x, y, 0.0f) * rm
      vsUniforms.mvp = viewProj * model
      gfx.applyPipeline(pipelines[src][dst])
      gfx.applyBindings(bindings)
      gfx.applyUniforms(ShaderStage.Vertex, 0, vsUniforms)
      gfx.draw(0, 4, 1)
    #
  #

  gfx.endPass()
  gfx.commit()
  r += 0.06f
  fsUniforms.tick += 1f
# app.frame