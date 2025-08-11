#-------------------------------------------------------------------------------
#   offscreen.nim
#   Render to an offscreen rendertarget texture, and use this texture
#   for rendering to the display.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/shape as sshape
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/offscreen as shd

const
  offscreenSampleCount = 1
  offscreenWidth = 256
  offscreenHeight = 256

var
  offscreenPass: Pass
  offscreenPip: Pipeline
  offscreenBindings: Bindings
  displayPassAction: PassAction
  displayPip: Pipeline
  displayBindings: Bindings
  donut, sphere: sshape.ElementRange
  rx, ry: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # default pass action: clear to blue-ish
  displayPassAction = PassAction(
    colors: [ ColorAttachmentAction( loadAction: loadActionClear, clearValue: (0.25, 0.45, 0.65, 1 )) ]
  )

  # offscreen pass action: clear to grey
  offscreenPass.action = PassAction(
    colors: [ ColorAttachmentAction( loadAction: loadActionClear, clearValue: (0.25, 0.25, 0.25, 1 )) ]
  )

  # setup the color- and depth-stencil-attachment images and views
  let colorImg = sg.makeImage(sg.ImageDesc(
    usage: ImageUsage(colorAttachment: true),
    width: offscreenWidth,
    height: offscreenHeight,
    pixelFormat: pixelFormatRgba8,
    sampleCount: offscreenSampleCount,
  ))
  let depthImg = sg.makeImage(sg.ImageDesc(
    usage: ImageUsage(depthStencilAttachment: true),
    width: offscreenWidth,
    height: offscreenHeight,
    pixelFormat: pixelFormatDepth,
    sampleCount: offscreenSampleCount
  ))

  # the offscreen render pass needs a color- and depth-stencil-attachment
  offscreenPass.attachments.colors[0] = sg.makeView(ViewDesc(
    colorAttachment: ImageViewDesc(image: colorImg)
  ))
  offscreenPass.attachments.depthStencil = sg.makeView(ViewDesc(
    depthStencilAttachment: ImageViewDesc(image: depthImg)
  ))

  # the display render pass needs a texture view on the color image
  displayBindings.views[viewTex] = sg.makeView(ViewDesc(
    texture: TextureViewDesc(image: colorImg)
  ))

  # a donut shape which is rendered into the offscreen render target, and
  # a sphere shape which is rendered into the default framebuffer
  var vertices: array[4000, sshape.Vertex]
  var indices: array[24000, uint16]
  var buf = sshape.Buffer(
    vertices: BufferItem(buffer: sshape.Range(addr: vertices.addr, size: vertices.sizeof)),
    indices: BufferItem(buffer: sshape.Range(addr: indices.addr, size: indices.sizeof))
  )
  buf = sshape.buildTorus(buf, Torus(radius:0.5, ringRadius:0.3, sides:20, rings:36))
  donut = sshape.elementRange(buf)
  buf = sshape.buildSphere(buf, Sphere(radius:0.5, slices: 72, stacks: 40))
  sphere = sshape.elementRange(buf)

  let vbuf = sg.makeBuffer(sshape.vertexBufferDesc(buf))
  offscreenBindings.vertexBuffers[0] = vbuf
  displayBindings.vertexBuffers[0] = vbuf
  let ibuf = sg.makeBuffer(sshape.indexBufferDesc(buf))
  offscreenBindings.indexBuffer = ibuf
  displayBindings.indexBuffer = ibuf

  # pipeline object for offscreen-rendered donut, don't need vertex coords here
  offscreenPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(offscreenShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      buffers: [ sshape.vertexBufferLayoutState() ],
      attrs: [
        sshape.positionVertexAttrState(),
        sshape.normalVertexAttrState()
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    sampleCount: offscreenSampleCount,
    depth: DepthState(
      pixelFormat: pixelFormatDepth,
      compare: compareFuncLessEqual,
      writeEnabled: true
    ),
    colors: [
      ColorTargetState(pixelFormat: pixelFormatRgba8)
    ]
  ))

  # ...and another pipeline object for the default pass
  displayPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(defaultShaderDesc(sg.queryBackend())),
    layout: VertexLayoutState(
      buffers: [ sshape.vertexBufferLayoutState() ],
      attrs: [
        sshape.positionVertexAttrState(),
        sshape.normalVertexAttrState(),
        sshape.texcoordVertexAttrState()
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    )
  ))

  # a sampler object for sampling the render target as texture
  displayBindings.samplers[smpSmp] = sg.makeSampler(SamplerDesc(
    minFilter: filterLinear,
    magFilter: filterLinear,
    wrapU: wrapRepeat,
    wrapV: wrapRepeat,
  ))

# a helper function to computer model-view-projection matrix
proc computeMVP(rx: float32, ry: float32, aspect: float32, eyeDist: float32): mat4.Mat4 =
  let proj = persp(45, aspect, 0.01, 10)
  let view = lookat(vec3(0, 0, eyeDist), vec3.zero(), vec3.up())
  let viewProj = proj * view
  let rxm = rotate(rx, vec3(1, 0, 0))
  let rym = rotate(ry, vec3(0, 1, 0))
  let model = rym * rxm
  result = viewProj * model

proc frame() {.cdecl.} =
  let t: float32 = sapp.frameDuration() * 60
  rx += 1f * t
  ry += 2f * t

  # the offscreen pass, rendering an rotating, untextured donut into a render target image
  let offscreenVsParams = shd.VsParams(
    mvp: computeMVP(rx, ry, 1.0, 2.5)
  )
  sg.beginPass(offscreenPass)
  sg.applyPipeline(offscreenPip)
  sg.applyBindings(offscreenBindings)
  sg.applyUniforms(shd.ubVsParams, sg.Range(addr: offscreenVsParams.addr, size: offscreenVsParams.sizeof))
  sg.draw(donut.baseElement, donut.numElements, 1)
  sg.endPass()

  # and the display-pass, rendering a rotating textured sphere which uses the
  # previously rendered offscreen render-target as texture
  let defaultVsParams = shd.VsParams(
    mvp: computeMVP(-rx * 0.25, ry * 0.25, sapp.widthf()/sapp.heightf(), 2.0)
  )
  sg.beginPass(Pass(action: displayPassAction, swapchain: sglue.swapchain()))
  sg.applyPipeline(displayPip)
  sg.applyBindings(displayBindings)
  sg.applyUniforms(shd.ubVsParams, sg.Range(addr: defaultVsParams.addr, size: offscreenVsParams.sizeof))
  sg.draw(sphere.baseElement, sphere.numElements, 1)
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
  windowTitle: "offscreen.nim",
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
