#-------------------------------------------------------------------------------
#   mrt.nim
#   Rendering with multi-rendertargets, and recreating render targets
#   when window size changes.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue
import math/mat4
import math/vec2
import math/vec3
import std/math
import shaders/mrt as shd

type Vertex = object
  x, y, z, b: float32

const
  offscreenSampleCount = 4

var
  offscreenPassAction: PassAction
  offscreenPassDesc: PassDesc
  offscreenPass: Pass
  offscreenPip: Pipeline
  offscreenBindings: Bindings
  fsqPip: Pipeline
  fsqBindings: Bindings
  dbgPip: Pipeline
  dbgBindings: Bindings
  defaultPassAction: PassAction
  rx, ry: float32

# called initially and when window size changes
proc createOffscreenPass(width: int32, height: int32) =
  # destroy previous resource (can be called for invalid id)
  sg.destroyPass(offscreenPass)
  for i in 0..<3:
    sg.destroyImage(offscreenPassDesc.colorAttachments[i].image)
  sg.destroyImage(offscreenPassDesc.depthStencilAttachment.image)

  # create offscreen rendertarget images and pass
  let offscreenSampleCount: int32 = if sg.queryFeatures().msaaRenderTargets: offscreenSampleCount else: 1
  let colorImageDesc = sg.ImageDesc(
    renderTarget: true,
    width: width,
    height: height,
    minFilter: Filter.linear,
    magFilter: Filter.linear,
    wrapU: Wrap.clampToEdge,
    wrapV: Wrap.clampToEdge,
    sampleCount: offscreenSampleCount
  )
  var depthImageDesc = colorImageDesc
  depthImageDesc.pixelFormat = PixelFormat.depth
  offscreenPassDesc = PassDesc(
    colorAttachments: [
      PassAttachmentDesc(image: sg.makeImage(colorImageDesc)),
      PassAttachmentDesc(image: sg.makeImage(colorImageDesc)),
      PassAttachmentDesc(image: sg.makeImage(colorImageDesc))
    ],
    depthStencilAttachment: PassAttachmentDesc(image: sg.makeImage(depthImageDesc))
  )
  offscreenPass = sg.makePass(offscreenPassDesc)

  # also need to update the fullscreen-quad texture bindings
  for i in 0..<3:
    fsqBindings.fsImages[i] = offscreenPassDesc.colorAttachments[i].image

# listen for window-resize events and recreate offscreen rendertargets
proc event(ev: ptr Event) {.cdecl.} =
  if ev.type == EventType.resized:
    createOffscreenPass(ev.framebufferWidth, ev.framebufferHeight)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: glue.context() ))

  # pass action for the default pass, since we overwrite the entire framebuffer, no clearing needs to happen
  defaultPassAction.colors[0].action = Action.dontCare
  defaultPassAction.depth.action = Action.dontCare
  defaultPassAction.stencil.action = Action.dontCare

  # pass action for offscreen pass
  offscreenPassAction.colors = [
    ColorAttachmentAction(action: Action.clear, value: (0.25, 0, 0, 1)),
    ColorAttachmentAction(action: Action.clear, value: (0, 0.25, 0, 1)),
    ColorAttachmentAction(action: Action.clear, value: (0, 0, 0.25, 1))
  ]

  # a render pass with 3 color attachment images, and a depth attachment image
  createOffscreenPass(sapp.width(), sapp.height())

  # a cube vertex buffer
  offscreenBindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: [
      # pos + brightness
      Vertex(x: -1.0f, y: -1.0f, z: -1.0f, b: 1.0f),
      Vertex(x:  1.0f, y: -1.0f, z: -1.0f, b: 1.0f),
      Vertex(x:  1.0f, y:  1.0f, z: -1.0f, b: 1.0f),
      Vertex(x: -1.0f, y:  1.0f, z: -1.0f, b: 1.0f),
      Vertex(x: -1.0f, y: -1.0f, z:  1.0f, b: 0.8f),
      Vertex(x:  1.0f, y: -1.0f, z:  1.0f, b: 0.8f),
      Vertex(x:  1.0f, y:  1.0f, z:  1.0f, b: 0.8f),
      Vertex(x: -1.0f, y:  1.0f, z:  1.0f, b: 0.8f),
      Vertex(x: -1.0f, y: -1.0f, z: -1.0f, b: 0.6f),
      Vertex(x: -1.0f, y:  1.0f, z: -1.0f, b: 0.6f),
      Vertex(x: -1.0f, y:  1.0f, z:  1.0f, b: 0.6f),
      Vertex(x: -1.0f, y: -1.0f, z:  1.0f, b: 0.6f),
      Vertex(x:  1.0f, y: -1.0f, z: -1.0f, b: 0.4f),
      Vertex(x:  1.0f, y:  1.0f, z: -1.0f, b: 0.4f),
      Vertex(x:  1.0f, y:  1.0f, z:  1.0f, b: 0.4f),
      Vertex(x:  1.0f, y: -1.0f, z:  1.0f, b: 0.4f),
      Vertex(x: -1.0f, y: -1.0f, z: -1.0f, b: 0.5f),
      Vertex(x: -1.0f, y: -1.0f, z:  1.0f, b: 0.5f),
      Vertex(x:  1.0f, y: -1.0f, z:  1.0f, b: 0.5f),
      Vertex(x:  1.0f, y: -1.0f, z: -1.0f, b: 0.5f),
      Vertex(x: -1.0f, y:  1.0f, z: -1.0f, b: 0.7f),
      Vertex(x: -1.0f, y:  1.0f, z:  1.0f, b: 0.7f),
      Vertex(x:  1.0f, y:  1.0f, z:  1.0f, b: 0.7f),
      Vertex(x:  1.0f, y:  1.0f, z: -1.0f, b: 0.7f),
    ]
  ))

  # cube index buffer
  offscreenBindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: BufferType.indexBuffer,
    data: [
      0'u16, 1, 2,  0, 2, 3,
      6, 5, 4,  7, 6, 4,
      8, 9, 10,  8, 10, 11,
      14, 13, 12,  15, 14, 12,
      16, 17, 18,  16, 18, 19,
      22, 21, 20,  23, 22, 20
    ]
  ))

  # shader and pipeline for offscreen-renderer cube
  offscreenPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(offscreenShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      buffers: [ BufferLayoutDesc(stride: sizeof(Vertex).int32) ],
      attrs: [
        VertexAttrDesc(offset: offsetOf(Vertex,x).int32, format: VertexFormat.float3),
        VertexAttrDesc(offset: offsetOf(Vertex,b).int32, format: VertexFormat.float)
      ]
    ),
    indexType: IndexType.uint16,
    cullMode: CullMode.back,
    sampleCount: offscreenSampleCount,
    depth: DepthState(
      pixelFormat: PixelFormat.depth,
      compare: CompareFunc.lessEqual,
      writeEnabled: true,
    ),
    colorCount: 3
  ))

  # a vertex buffer to create a fullscreen rectangle
  let quadVbuf = sg.makeBuffer(BufferDesc(
    data: [ 0.0f, 0.0f,  1.0f, 0.0f,  0.0f, 1.0f,  1.0f, 1.0f ]
  ))

  # shader, pipeline and bindings to compose 3 offscreen render targets into default framebuffer
  fsqPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(fsqShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: VertexFormat.float2)
      ]
    ),
    primitiveType: PrimitiveType.triangleStrip,
  ))
  fsqBindings = Bindings(
    vertexBuffers: [ quadVbuf ],
    fsImages: [
      offscreenPassDesc.colorAttachments[0].image,
      offscreenPassDesc.colorAttachments[1].image,
      offscreenPassDesc.colorAttachments[2].image
    ]
  )

  # shader, pipeline and bindings to render debug-visualization quads
  dbgPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(dbgShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: VertexFormat.float2)
      ]
    ),
    primitiveType: PrimitiveType.triangleStrip,
  ))
  dbgBindings.vertexBuffers[0] = quadVbuf

proc frame() {.cdecl.} =
  let t = sapp.frameDuration().float32 * 60
  rx += 1f * t
  ry += 2f * t

  # view-projection matrix
  let proj = persp(60, sapp.widthf()/sapp.heightf(), 0.01, 10)
  let view = lookat(vec3(0, 1.5, 6), vec3.zero(), vec3.up())
  let viewProj = proj * view

  # shader uniforms
  let rxm = rotate(rx, vec3(1, 0, 0))
  let rym = rotate(ry, vec3(0, 1, 0))
  let model = rxm * rym
  let offscreenParams = OffscreenParams(mvp: view_proj * model)
  let fsqParams = FsqParams(offset: vec2(math.sin(rx*0.01)*0.1, math.sin(ry*0.01)*0.1))

  # render cube into MRT offscreen render targets
  sg.beginPass(offscreenPass, offscreenPassAction)
  sg.applyPipeline(offscreenPip)
  sg.applyBindings(offscreenBindings)
  sg.applyUniforms(ShaderStage.vs, shd.slotOffscreenParams, offscreenParams)
  sg.draw(0, 36, 1)
  sg.endPass()

  # render fullscreen quad with the 'composed image', plus 3 small debug-view quads
  sg.beginDefaultPass(defaultPassAction, sapp.width(), sapp.height())
  sg.applyPipeline(fsqPip)
  sg.applyBindings(fsqBindings)
  sg.applyUniforms(ShaderStage.vs, shd.slotFsqParams, fsqParams)
  sg.draw(0, 4, 1)
  sg.applyPipeline(dbgPip)
  for i in 0..<3:
    sg.applyViewport(i.int32*100, 0, 100, 100, false)
    dbgBindings.fsImages[0] = offscreenPassDesc.colorAttachments[i].image
    sg.applyBindings(dbgBindings)
    sg.draw(0, 4, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  eventCb: event,
  cleanupCb: cleanup,
  width: 800,
  height: 600,
  sampleCount: 4,
  windowTitle: "mrt.nim"
))
