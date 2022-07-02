#-------------------------------------------------------------------------------
#   noninterleaved.zig
#
#   How to use non-interleaved vertex data (vertex components in
#   separate non-interleaved chunks in the same vertex buffers). Note
#   that only 4 separate chunks are currently possible because there
#   are 4 vertex buffer bind slots in sg_bindings, but you can keep
#   several related vertex components interleaved in the same chunk.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/noninterleaved as shd

var
  rx: float32 = 0
  ry: float32 = 0
  pip: Pipeline
  bindings: Bindings
  passAction: PassAction

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))

  # cube vertex buffer, NOTE how the vertex components are separate
  const vertices = [
    # positions
    -1'f32, -1.0, -1.0,   1.0, -1.0, -1.0,   1.0,  1.0, -1.0,  -1.0,  1.0, -1.0,
    -1.0,   -1.0,  1.0,   1.0, -1.0,  1.0,   1.0,  1.0,  1.0,  -1.0,  1.0,  1.0,
    -1.0,   -1.0, -1.0,  -1.0,  1.0, -1.0,  -1.0,  1.0,  1.0,  -1.0, -1.0,  1.0,
     1.0,   -1.0, -1.0,   1.0,  1.0, -1.0,   1.0,  1.0,  1.0,   1.0, -1.0,  1.0,
    -1.0,   -1.0, -1.0,  -1.0, -1.0,  1.0,   1.0, -1.0,  1.0,   1.0, -1.0, -1.0,
    -1.0,    1.0, -1.0,  -1.0,  1.0,  1.0,   1.0,  1.0,  1.0,   1.0,  1.0, -1.0,
    # colors
    1.0, 0.5, 0.0, 1.0,  1.0, 0.5, 0.0, 1.0,  1.0, 0.5, 0.0, 1.0,  1.0, 0.5, 0.0, 1.0,
    0.5, 1.0, 0.0, 1.0,  0.5, 1.0, 0.0, 1.0,  0.5, 1.0, 0.0, 1.0,  0.5, 1.0, 0.0, 1.0,
    0.5, 0.0, 1.0, 1.0,  0.5, 0.0, 1.0, 1.0,  0.5, 0.0, 1.0, 1.0,  0.5, 0.0, 1.0, 1.0,
    1.0, 0.5, 1.0, 1.0,  1.0, 0.5, 1.0, 1.0,  1.0, 0.5, 1.0, 1.0,  1.0, 0.5, 1.0, 1.0,
    0.5, 1.0, 1.0, 1.0,  0.5, 1.0, 1.0, 1.0,  0.5, 1.0, 1.0, 1.0,  0.5, 1.0, 1.0, 1.0,
    1.0, 1.0, 0.5, 1.0,  1.0, 1.0, 0.5, 1.0,  1.0, 1.0, 0.5, 1.0,  1.0, 1.0, 0.5, 1.0,
  ]
  let vbuf = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: vertices.unsafeAddr, size: vertices.sizeof)
  ))

  # cube index buffer
  let indices = [
    0'u16, 1, 2,  0, 2, 3,
    6, 5, 4,  7, 6, 4,
    8, 9, 10,  8, 10, 11,
    14, 13, 12,  15, 14, 12,
    16, 17, 18,  16, 18, 19,
    22, 21, 20,  23, 22, 20
  ]
  let ibuf = sg.makeBuffer(BufferDesc(
      type: bufferTypeIndexBuffer,
      data: sg.Range(addr: indices.unsafeAddr, size: indices.sizeof)
  ))

  # shader and pipeline object
  # NOTE how the vertex components are pulled from different buffer bind slots
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shd.noninterleavedShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: vertexFormatFloat3, bufferIndex: 0),
        VertexAttrDesc(format: vertexFormatFloat4, bufferIndex: 1),
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    ),
  ))

  # fill the resource bindings, note how the same vertex
  # buffer is bound to the first two slots, and the vertex-buffer-offsets
  # are used to point to the position- and color-components.
  bindings = Bindings(
    vertexBuffers: [ vbuf, vbuf ],
    vertexBufferOffsets: [ 0'i32, 24 * 3 * sizeof(float32)],
    indexBuffer: ibuf,
  )

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
  let vsParams = computeVsParams()
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.applyUniforms(shaderStageVs, shd.slotVsParams, sg.Range(addr: vsParams.unsafeAddr, size: vsParams.sizeof))
  sg.draw(0, 36, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 800,
  height: 600,
  sampleCount: 4,
  windowTitle: "noninterleaved.nim",
  icon: IconDesc(sokol_default: true)
))
