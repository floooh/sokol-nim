#-------------------------------------------------------------------------------
# cube.nim
# Shader with uniform data
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue
import math/vec3
import math/mat4
import shaders/cube as shd

var
  pip: Pipeline
  bindings: Bindings
  rx: float32 = 0
  ry: float32 = 0

const
  passAction = PassAction(
    colors:[
      ColorAttachmentAction(action: actionClear, value: (0.5, 0.5, 0.5, 1))
    ]
  )

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: glue.context()))

  let vbuf = sg.makeBuffer(BufferDesc(
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
    ]
  ))

  let ibuf = sg.makeBuffer(BufferDesc(
    type: bufferTypeIndexBuffer,
    data: [
      0'u16, 1, 2,  0, 2, 3,
      6, 5, 4,      7, 6, 4,
      8, 9, 10,     8, 10, 11,
      14, 13, 12,   15, 14, 12,
      16, 17, 18,   16, 18, 19,
      22, 21, 20,   23, 22, 20,
    ]
  ))

  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.cubeShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      buffers: [
        BufferLayoutDesc(stride: 28),
      ],
      attrs: [
        VertexAttrDesc(bufferIndex: 0, offset: 0,  format: vertexFormatFloat3),
        VertexAttrDesc(bufferIndex: 0, offset: 12, format: vertexFormatFloat4),
      ],
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    )
  ))

  bindings = Bindings(vertexBuffers: [vbuf], indexBuffer: ibuf)

proc computeVsParams(): shd.VsParams =
  let proj = persp(60.0f, sapp.widthf()/sapp.heightf(), 0.01f, 10.0f)
  let view = lookat(vec3(0.0f, 1.5f, 6.0f), vec3.zero(), vec3.up())
  let rxm = rotate(rx, vec3(1f, 0f, 0f))
  let rym = rotate(ry, vec3(0f, 1f, 0f))
  let model = rxm * rym
  result = VsParams(mvp: proj * view * model)

proc frame() {.cdecl.} =
  let dt = sapp.frameDuration() * 60f;
  rx += 1f * dt;
  ry += 2f * dt;
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.applyUniforms(shaderStageVs, shd.slotVsParams, computeVsParams())
  sg.draw(0, 36, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  windowTitle: "cube.nim",
  width: 800,
  height: 600,
  sampleCount: 4,
))
