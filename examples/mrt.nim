#-------------------------------------------------------------------------------
#   mrt.nim
#   Rendering with multi-rendertargets, and recreating render targets
#   when window size changes.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as sglue
import math/mat4
import math/vec2
import math/vec3
import std/math
import shaders/mrt as shd

type Vertex = object
  x, y, z, b: float32

const
  offscreenSampleCount = 1

var
  offscreenPassAction: PassAction
  offscreenAttachmentsDesc: AttachmentsDesc
  offscreenAttachments: Attachments
  offscreenPip: Pipeline
  offscreenBindings: Bindings
  fsqPip: Pipeline
  fsqBindings: Bindings
  dbgPip: Pipeline
  dbgBindings: Bindings
  defaultPassAction: PassAction
  rx, ry: float32

# called initially and when window size changes
proc createOffscreenAttachments(width: int32, height: int32) =
  # destroy previous resource (can be called for invalid id)
  sg.destroyAttachments(offscreenAttachments)
  for i in 0..<3:
    sg.destroyImage(offscreenAttachmentsDesc.colors[i].image)
  sg.destroyImage(offscreenAttachmentsDesc.depthStencil.image)

  # create offscreen rendertarget images and pass
  let colorImageDesc = sg.ImageDesc(
    usage: ImageUsage(renderAttachment: true),
    width: width,
    height: height,
    sampleCount: offscreenSampleCount
  )
  var depthImageDesc = colorImageDesc
  depthImageDesc.pixelFormat = pixelFormatDepth
  offscreenAttachmentsDesc = sg.AttachmentsDesc(
    colors: [
      AttachmentDesc(image: sg.makeImage(colorImageDesc)),
      AttachmentDesc(image: sg.makeImage(colorImageDesc)),
      AttachmentDesc(image: sg.makeImage(colorImageDesc))
    ],
    depthStencil: AttachmentDesc(image: sg.makeImage(depthImageDesc))
  )
  offscreenAttachments = sg.makeAttachments(offscreenAttachmentsDesc)

  # also need to update the fullscreen-quad texture bindings
  for i in 0..<3:
    fsqBindings.images[i] = offscreenAttachmentsDesc.colors[i].image

# listen for window-resize events and recreate offscreen rendertargets
proc event(ev: ptr Event) {.cdecl.} =
  if ev.type == eventTypeResized:
    createOffscreenAttachments(ev.framebufferWidth, ev.framebufferHeight)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # pass action for the default pass, since we overwrite the entire framebuffer, no clearing needs to happen
  defaultPassAction.colors[0].loadAction = loadActionDontCare
  defaultPassAction.depth.loadAction = loadActionDontCare
  defaultPassAction.stencil.loadAction = loadActionDontCare

  # pass action for offscreen pass
  offscreenPassAction.colors = [
    ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.25, 0, 0, 1)),
    ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0, 0.25, 0, 1)),
    ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0, 0, 0.25, 1))
  ]

  # a render pass with 3 color attachment images, and a depth attachment image
  createOffscreenAttachments(sapp.width(), sapp.height())

  # a cube vertex buffer
  const cubeVertices = [
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
  offscreenBindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: cubeVertices.addr, size: cubeVertices.sizeof)
  ))

  # cube index buffer
  const cubeIndices = [
    0'u16, 1, 2,  0, 2, 3,
    6, 5, 4,  7, 6, 4,
    8, 9, 10,  8, 10, 11,
    14, 13, 12,  15, 14, 12,
    16, 17, 18,  16, 18, 19,
    22, 21, 20,  23, 22, 20
  ]
  offscreenBindings.indexBuffer = sg.makeBuffer(BufferDesc(
    usage: BufferUsage(indexBuffer: true),
    data: sg.Range(addr: cubeIndices.addr, size: cubeIndices.sizeof)
  ))

  # shader and pipeline for offscreen-renderer cube
  offscreenPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(offscreenShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      buffers: [ VertexBufferLayoutState(stride: sizeof(Vertex).int32) ],
      attrs: [
        VertexAttrState(offset: offsetOf(Vertex,x).int32, format: vertexFormatFloat3),
        VertexAttrState(offset: offsetOf(Vertex,b).int32, format: vertexFormatFloat)
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    sampleCount: offscreenSampleCount,
    depth: DepthState(
      pixelFormat: pixelFormatDepth,
      compare: compareFuncLessEqual,
      writeEnabled: true,
    ),
    colorCount: 3
  ))

  # a vertex buffer to create a fullscreen rectangle
  const quadVertices = [ 0.0f, 0.0f,  1.0f, 0.0f,  0.0f, 1.0f,  1.0f, 1.0f ]
  let quadVbuf = sg.makeBuffer(BufferDesc(
    data: sg.Range(addr: quadVertices.addr, size: quadVertices.sizeof)
  ))

  # create a sampler for sampling the render targets as textures
  let smp = sg.makeSampler(SamplerDesc(
    minFilter: filterLinear,
    magFilter: filterLinear,
    wrapU: wrapClampToEdge,
    wrapV: wrapClampToEdge,
  ));

  # shader, pipeline and bindings to compose 3 offscreen render targets into default framebuffer
  fsqPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(fsqShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      attrs: [
        VertexAttrState(format: vertexFormatFloat2)
      ]
    ),
    primitiveType: primitiveTypeTriangleStrip,
  ))

  fsqBindings = Bindings(
    vertexBuffers: [ quadVbuf ],
    images: [
      offscreenAttachmentsDesc.colors[0].image,
      offscreenAttachmentsDesc.colors[1].image,
      offscreenAttachmentsDesc.colors[2].image
    ],
    samplers: [
      smp,
    ]
  )

  # shader, pipeline and bindings to render debug-visualization quads
  dbgPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(dbgShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      attrs: [
        VertexAttrState(format: vertexFormatFloat2)
      ]
    ),
    primitiveType: primitiveTypeTriangleStrip,
  ))
  dbgBindings.vertexBuffers[0] = quadVbuf
  dbgBindings.samplers[0] = smp

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
  sg.beginPass(Pass(action: offscreenPassAction, attachments: offscreenAttachments))
  sg.applyPipeline(offscreenPip)
  sg.applyBindings(offscreenBindings)
  sg.applyUniforms(shd.ubOffscreenParams, sg.Range(addr: offscreenParams.addr, size: offscreenParams.sizeof))
  sg.draw(0, 36, 1)
  sg.endPass()

  # render fullscreen quad with the 'composed image', plus 3 small debug-view quads
  sg.beginPass(Pass(action: defaultPassAction, swapchain: sglue.swapchain()))
  sg.applyPipeline(fsqPip)
  sg.applyBindings(fsqBindings)
  sg.applyUniforms(shd.ubFsqParams, sg.Range(addr: fsqParams.addr, size: fsqParams.sizeof))
  sg.draw(0, 4, 1)
  sg.applyPipeline(dbgPip)
  for i in 0..<3:
    sg.applyViewport(i.int32*100, 0, 100, 100, false)
    dbgBindings.images[0] = offscreenAttachmentsDesc.colors[i].image
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
  windowTitle: "mrt.nim",
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
