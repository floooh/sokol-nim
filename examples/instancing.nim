#-------------------------------------------------------------------------------
#   instancing.nim
#   Demonstrate simple hardware-instancing using a static geometry buffer
#   and a dynamic instance-data buffer.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/instancing as shd
import std/random

const
  maxParticles = 512 * 1024
  numParticlesEmittedPerFrame = 10

var
  passAction: PassAction
  pip: Pipeline
  bindings: Bindings
  ry: float32
  curNumParticles: int
  pos: array[maxParticles, Vec3]
  vel: array[maxParticles, Vec3]

proc init() {.cdecl.} =
  sg.setup(sg.Desc( context: sglue.context() ))

  # a pass action for the default render pass (clears to black)
  passAction = PassAction(
    colors: [ ColorAttachmentAction( action: actionClear, value: (0, 0, 0, 1)) ]
  )

  # a vertex buffer for the static geometry, goes into vertex buffer bind slot 0
  const r = 0.05f
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: [
      # positions             colors
      0.0f,   -r, 0.0f,       1.0f, 0.0f, 0.0f, 1.0f,
         r, 0.0f,  r,         0.0f, 1.0f, 0.0f, 1.0f,
         r, 0.0f, -r,         0.0f, 0.0f, 1.0f, 1.0f,
        -r, 0.0f, -r,         1.0f, 1.0f, 0.0f, 1.0f,
        -r, 0.0f, r,          0.0f, 1.0f, 1.0f, 1.0f,
      0.0f,    r, 0.0f,       1.0f, 0.0f, 1.0f, 1.0f
    ]
  ))

  # index buffer for static geometry
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: bufferTypeIndexBuffer,
    data: [
      0'u16, 1, 2,  0, 2, 3,    0, 3, 4,    0, 4, 1,
      5, 1, 2,      5, 2, 3,    5, 3, 4,    5, 4, 1
    ]
  ))

  # empty, dynamic instance-data vertex buffer, goes into vertex-buffer-slot 1
  bindings.vertexBuffers[1] = sg.makeBuffer(BufferDesc(
    size: maxParticles * sizeof(Vec3),
    usage: usageStream
  ))

  # shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(instancingShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      # vertex buffer at slot 1 must step per instance
      buffers: [
        BufferLayoutDesc(),
        BufferLayoutDesc( stepFunc: vertexStepPerInstance )
      ],
      attrs: [
        VertexAttrDesc(format: vertexFormatFloat3, bufferIndex: 0),  # pos
        VertexAttrDesc(format: vertexFormatFloat4, bufferIndex: 0),  # color0
        VertexAttrDesc(format: vertexFormatFloat3, bufferIndex: 1),  # inst_pos
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    )
  ))

proc frame() {.cdecl.} =
  let frameTime = sapp.frameDuration().float32

  # emit new particles
  for i in 0..<numParticlesEmittedPerFrame:
    if curNumParticles < maxParticles:
      pos[curNumParticles] = vec3.zero()
      vel[curNumParticles] =  vec3(
        (rand(0x7FFF).float32 / 0x7FFF.float32) - 0.5,
        (rand(0x7FFF).float32 / 0x7FFF.float32) * 0.5 + 2.0,
        (rand(0x7FFF).float32 / 0x7FFF.float32) - 0.5
      )
      curNumParticles += 1
    else:
      break

  # update particle positions
  for i in 0..<curNumParticles:
    vel[i].y -= 1f * frameTime
    pos[i] = pos[i] + vel[i] * frameTime
    # bounce back from ground
    if pos[i].y < -2f:
      pos[i].y = -1.8f
      vel[i].y = -vel[i].y
      vel[i] = vel[i] * 0.8

  # update instance data
  # FIXME: this is awkward, we'd need a slice-to-Range converter
  sg.updateBuffer(bindings.vertexBuffers[1], sg.Range(
    pointer: unsafeAddr(pos),
    size: (curNumParticles * sizeof(Vec3)).uint
  ))

  # model-view-projection data
  let proj = persp(60, sapp.widthf() / sapp.heightf(), 0.01, 50.0)
  let view = lookat(vec3(0, 1.5, 12), vec3.zero(), vec3.up())
  ry += 60 * frameTime
  let model = rotate(ry, vec3.up())
  let vsParams = shd.VsParams(mvp: proj * view * model)

  # ...and draw
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.applyUniforms(shaderStageVs, shd.slotVsParams, vsParams)
  sg.draw(0, 24, curNumParticles.int32)
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
  windowTitle: "instancing.nim"
))
