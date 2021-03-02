# just clears the framebuffer:
#
#   - basic initialization and draw loop
#   - clearing through a pass action

import glm
import sokol/[app,gfx]
import sugar

# the app.cleanup callback will be invoked when the app window is closed
app.cleanup = () => gfx.shutdown()

# the app.event callback will be invoked for each user input event
app.event = (e:app.Event) => echo(e.type)

# the app.fail callback will be called in case of any app startup errors
app.fail = (s:string) => echo("err: " & s)

# statements at module scope are executed by sokol/app's init callback
gfx.setup(gfx.Desc(context:app.gfxContext()))

# cube vertices and vertex buffer
var vertices:array[168, float32] = [
  # position             color0
  -1.0f, -1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
   1.0f, -1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
  -1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,

  -1.0f, -1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
   1.0f,  1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
  -1.0f,  1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,

  -1.0f, -1.0f, -1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f,  1.0f, -1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f,  1.0f,  1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f, -1.0f,  1.0f,   0.0f, 0.0f, 1.0f, 1.0f,

   1.0f, -1.0f, -1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f,  1.0f,  1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   1.0f, 0.5f, 0.0f, 1.0f,

  -1.0f, -1.0f, -1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
  -1.0f, -1.0f,  1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
   1.0f, -1.0f, -1.0f,   0.0f, 0.5f, 1.0f, 1.0f,

  -1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
  -1.0f,  1.0f,  1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
   1.0f,  1.0f,  1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
]
let vbuf = gfx.makeBuffer(gfx.BufferDesc(
  type:BufferType.VertexBuffer,
  data:vertices,
  label:"cube-vertices",
))

# cube indices and index buffer
var indices:array[36, uint16] = [
   0u16, 1,  2,   0,  2,  3,
   6,    5,  4,   7,  6,  4,
   8,    9, 10,   8, 10, 11,
  14,   13, 12,  15, 14, 12,
  16,   17, 18,  16, 18, 19,
  22,   21, 20,  23, 22, 20,
]
let ibuf = gfx.makeBuffer(gfx.BufferDesc(
  label:"cube-indices",
  type:BufferType.IndexBuffer,
  data:indices,
))

type Uniforms = object
  mvp:Mat4f

let shader = gfx.makeShader(ShaderDesc(
  attrs:[
    ShaderAttrDesc(semName:"POSITION"),
    ShaderAttrDesc(semName:"COLOR", semIndex:0),
  ],
  vs:ShaderStageDesc(
    uniformBlocks:[
      ShaderUniformBlockDesc(
        size:sizeof(Uniforms),
        uniforms:[
          ShaderUniformDesc(name:"mvp", type:UniformType.Mat4)
        ]
      )
    ],
    source:
      when app.gl: # compiled for OpenGL or OpenGL ES
        """
        #version 330
        uniform mat4 mvp;

        layout(location=0) in vec4 position;
        layout(location=1) in vec4 color0;

        out vec4 color;

        void main() {
            gl_Position = mvp * position;
            color = color0;
        }
        """
      elif app.d3d11: # compiled for Windows Direct3D 11
        """
        cbuffer Uniforms {
          float4x4 mvp;
        };

        struct vertex {
          float4 position :POSITION;
          float4 color0   :COLOR0;
        };

        struct fragment {
          float4 position :SV_Position;
          float4 color    :COLOR;
        };

        fragment main(vertex v) {
          fragment f;
          f.position = mul(mvp, v.position);
          f.color = v.color0;
          return f;
        }
        """
      else:nil,
  ),
  fs:ShaderStageDesc(
    source:
      when app.gl:
        """
        #version 330

        in vec4 color;

        out vec4 frag_color;

        void main() {
            frag_color = color;
        }
        """
      elif app.d3d11:
        """
        struct fragment {
          float4 position :SV_Position;
          float4 color    :COLOR;
        };

        float4 main(fragment f) :SV_Target {
          return f.color;
        }
        """
      else:nil,
  )
))

let pipeline = gfx.makePipeline(PipelineDesc(
    layout:LayoutDesc(
      buffers:[
        BufferLayoutDesc(stride:28),
      ],
      attrs:[
        VertexAttrDesc(bufferIndex:0, offset:0,  format:VertexFormat.Float3),
        VertexAttrDesc(bufferIndex:0, offset:12, format:VertexFormat.Float4),
      ],
    ),
    shader:shader,
    indexType:IndexType.Uint16,
    cullMode:CullMode.Back,
    depth:DepthState(
      compare:CompareFunc.LessEqual,
      writeEnabled:true,
    ),
    label:"cube-pipeline",
))

var bindings = gfx.Bindings(
    vertexBuffers:[vbuf],
    indexBuffer:ibuf,
)

var passAction = gfx.PassAction(
  colors:[
    gfx.ColorAttachmentAction(
      action:Action.Clear,
      value:(1,0,0,0),
    ),
  ]
)

var uniforms = Uniforms()
var rx, ry = 0f

app.frame = proc() =
  let proj = perspective(
    fovy   = radians(60f),
    aspect = app.widthf()/app.heightf(),
    zNear  = 0.01f,
    zFar   = 100f)
  let view = lookAt(
    eye    = vec3(0f, 1.5f, 6f),
    center = vec3(0f, 0f, 0f),
    up     = vec3(0f, 1f, 0f))
  rx += 1f
  ry += 2f;
  var rxm = rotate(mat4f(1f), radians(rx), 1f, 0f, 0f)
  var rym = rotate(mat4f(1f), radians(ry), 0f, 1f, 0f)
  var model = rxm * rym
  var mvp = proj * view * model

  uniforms.mvp = mvp

  var g = passAction.colors[0].value.g + 0.01f
  passAction.colors[0].value.g = if g > 1f: 0f else: g

  gfx.beginDefaultPass(passAction, app.width(), app.height())
  gfx.applyPipeline(pipeline)
  gfx.applyBindings(bindings)
  gfx.applyUniforms(ShaderStage.Vertex, 0, uniforms)
  gfx.draw(0, 36, 1)
  gfx.endPass()
  gfx.commit()
# app.frame