#-------------------------------------------------------------------------------
# cube.nim
# Shader with uniform data
#-------------------------------------------------------------------------------

import glm
import sokol/[gfx, app, glue]
import shaders/cube as shd

type Uniforms = object
  mvp: Mat4f

var pipeline: Pipeline
var bindings: Bindings

const passAction = PassAction(
  colors:[
    ColorAttachmentAction(
      action: Action.clear,
      value: (0.5, 0.5, 0.5, 1),
    ),
  ]
)

proc init() {.cdecl.} =
  setup(gfx.Desc(context: glue.context()))

  let vbuf = makeBuffer(
    BufferDesc(
      type: BufferType.vertexBuffer,
      data: [
        # position             color0
        -1.0'f32, -1.0, -1.0,  1.0, 0.0, 0.0, 1.0,
         1.0, -1.0, -1.0,      1.0, 0.0, 0.0, 1.0,
         1.0,  1.0, -1.0,      1.0, 0.0, 0.0, 1.0,
        -1.0,  1.0, -1.0,      1.0, 0.0, 0.0, 1.0,

        -1.0, -1.0,  1.0,      0.0, 1.0, 0.0, 1.0,
         1.0, -1.0,  1.0,      0.0, 1.0, 0.0, 1.0,
         1.0,  1.0,  1.0,      0.0, 1.0, 0.0, 1.0,
        -1.0,  1.0,  1.0,      0.0, 1.0, 0.0, 1.0,

        -1.0, -1.0, -1.0,      0.0, 0.0, 1.0, 1.0,
        -1.0,  1.0, -1.0,      0.0, 0.0, 1.0, 1.0,
        -1.0,  1.0,  1.0,      0.0, 0.0, 1.0, 1.0,
        -1.0, -1.0,  1.0,      0.0, 0.0, 1.0, 1.0,

         1.0, -1.0, -1.0,      1.0, 0.5, 0.0, 1.0,
         1.0,  1.0, -1.0,      1.0, 0.5, 0.0, 1.0,
         1.0,  1.0,  1.0,      1.0, 0.5, 0.0, 1.0,
         1.0, -1.0,  1.0,      1.0, 0.5, 0.0, 1.0,

        -1.0, -1.0, -1.0,      0.0, 0.5, 1.0, 1.0,
        -1.0, -1.0,  1.0,      0.0, 0.5, 1.0, 1.0,
         1.0, -1.0,  1.0,      0.0, 0.5, 1.0, 1.0,
         1.0, -1.0, -1.0,      0.0, 0.5, 1.0, 1.0,

        -1.0,  1.0, -1.0,      1.0, 0.0, 0.5, 1.0,
        -1.0,  1.0,  1.0,      1.0, 0.0, 0.5, 1.0,
         1.0,  1.0,  1.0,      1.0, 0.0, 0.5, 1.0,
         1.0,  1.0, -1.0,      1.0, 0.0, 0.5, 1.0,
      ],
      label: "cube-vertices",
    )
  )

  let ibuf = makeBuffer(
    BufferDesc(
      type: BufferType.indexBuffer,
      data: [
        0'u16, 1, 2,  0, 2, 3,
        6, 5, 4,      7, 6, 4,
        8, 9, 10,     8, 10, 11,
        14, 13, 12,   15, 14, 12,
        16, 17, 18,   16, 18, 19,
        22, 21, 20,   23, 22, 20,
      ],
      label: "cube-indices",
    )
  )

  let shader = makeShader(shd.cubeShaderDesc(queryBackend()))

  pipeline = makePipeline(
    PipelineDesc(
      layout: LayoutDesc(
        buffers: [
          BufferLayoutDesc(stride: 28),
        ],
        attrs: [
          VertexAttrDesc(bufferIndex: 0, offset: 0,  format: VertexFormat.float3),
          VertexAttrDesc(bufferIndex: 0, offset: 12, format: VertexFormat.float4),
        ],
      ),
      shader: shader,
      indexType: IndexType.uint16,
      cullMode: CullMode.back,
      depth: DepthState(
        compare: CompareFunc.lessEqual,
        writeEnabled: true,
      ),
      label: "cube-pipeline",
    )
  )

  bindings = Bindings(
    vertexBuffers: [vbuf],
    indexBuffer: ibuf,
  )

var uniforms = Uniforms()
var rx, ry = 0f

proc frame() {.cdecl.} =
  let proj = perspective(
    fovy   = radians(60.0f),
    aspect = app.widthf() / app.heightf(),
    zNear  = 0.01f,
    zFar   = 100.0f)
  let view = lookAt(
    eye    = vec3(0.0f, 1.5f, 6.0f),
    center = vec3(0.0f, 0.0f, 0.0f),
    up     = vec3(0.0f, 1.0f, 0.0f))
  rx += 1.0f
  ry += 2.0f
  var rxm = rotate(mat4f(1.0f), radians(rx), 1.0f, 0.0f, 0.0f)
  var rym = rotate(mat4f(1.0f), radians(ry), 0.0f, 1.0f, 0.0f)
  var model = rxm * rym
  var mvp = proj * view * model

  uniforms.mvp = mvp

  beginDefaultPass(passAction, app.width(), app.height())
  applyPipeline(pipeline)
  applyBindings(bindings)
  applyUniforms(ShaderStage.vs, 0, uniforms)
  draw(0, 36, 1)
  endPass()
  commit()

proc cleanup() {.cdecl.} =
  shutdown()

proc fail(reason: cstring) {.cdecl.} =
  echo "sokol error: ", reason

app.run(app.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  failCb: fail,
  windowTitle: "cube.nim",
  width: 640,
  height: 480,
  sampleCount: 4,
  win32ConsoleAttach: true,
  win32ConsoleUtf8: true,
))
