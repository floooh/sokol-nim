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
  offscreenSampleCount: int32 = 1
  offscreenWidth: int32 = 256
  offscreenHeight: int32 = 256

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
  displayPassAction.colors[0] = ColorAttachmentAction( loadAction: loadActionClear, clearValue: (0.25f, 0.45f, 0.65f, 1.0f) )

  # offscreen pass action: clear to grey
  offscreenPass.action.colors[0] = ColorAttachmentAction( loadAction: loadActionClear, clearValue: (0.25f, 0.25f, 0.25f, 1.0f) )

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
  var vertices: array[4000 * sshape.maxVertexSize, uint8]
  var indices: array[24000, uint16]
  var shp = sshape.State(
    vertices: BufferState(buffer: sshape.Range(addr: vertices.addr, size: vertices.sizeof)),
    indices: BufferState(buffer: sshape.Range(addr: indices.addr, size: indices.sizeof))
  )
  sshape.buildTorus(shp.addr, Torus(radius:0.5f, ringRadius:0.3f, sides:20, rings:36))
  donut = sshape.elementRange(shp)
  sshape.buildSphere(shp.addr, Sphere(radius:0.5f, slices: 72, stacks: 40))
  sphere = sshape.elementRange(shp)

  let vbuf = sg.makeBuffer(sshape.vertexBufferDesc(shp))
  offscreenBindings.vertexBuffers[0] = vbuf
  displayBindings.vertexBuffers[0] = vbuf
  let ibuf = sg.makeBuffer(sshape.indexBufferDesc(shp))
  offscreenBindings.indexBuffer = ibuf
  displayBindings.indexBuffer = ibuf

  # pipeline object for offscreen-rendered donut, don't need vertex coords here
  offscreenPip = sg.makePipeline:
    var opd = PipelineDesc(
      shader: sg.makeShader(offscreenShaderDesc(sg.queryBackend())),
      indexType: indexTypeUint16,
      cullMode: cullModeBack,
      sampleCount: offscreenSampleCount,
      depth: DepthState(
        pixelFormat: pixelFormatDepth,
        compare: compareFuncLessEqual,
        writeEnabled: true
      )
    )
    opd.layout.buffers[0] = sshape.vertexBufferLayoutState(shp)
    opd.layout.attrs[0] = sshape.positionVertexAttrState(shp)
    opd.layout.attrs[1] = sshape.normalVertexAttrState(shp)
    opd.colors[0] = ColorTargetState(pixelFormat: pixelFormatRgba8)
    opd

  # ...and another pipeline object for the default pass
  displayPip = sg.makePipeline:
    var dpd = PipelineDesc(
      shader: sg.makeShader(defaultShaderDesc(sg.queryBackend())),
      indexType: indexTypeUint16,
      cullMode: cullModeBack,
      depth: DepthState(
        compare: compareFuncLessEqual,
        writeEnabled: true,
      )
    )
    dpd.layout.buffers[0] = sshape.vertexBufferLayoutState(shp)
    dpd.layout.attrs[0] = sshape.positionVertexAttrState(shp)
    dpd.layout.attrs[1] = sshape.normalVertexAttrState(shp)
    dpd.layout.attrs[2] = sshape.texcoordVertexAttrState(shp)
    dpd

  # a sampler object for sampling the render target as texture
  displayBindings.samplers[smpSmp] = sg.makeSampler(SamplerDesc(
    minFilter: filterLinear,
    magFilter: filterLinear,
    wrapU: wrapRepeat,
    wrapV: wrapRepeat,
  ))

# a helper function to computer model-view-projection matrix
proc computeMVP(rx: float32, ry: float32, aspect: float32, eyeDist: float32): mat4.Mat4 =
  let proj = persp(45.0f, aspect, 0.01f, 10.0f)
  let view = lookat(vec3(0.0f, 0.0f, eyeDist), vec3.zero(), vec3.up())
  let viewProj = proj * view
  let rxm = rotate(rx, vec3(1.0f, 0.0f, 0.0f))
  let rym = rotate(ry, vec3(0.0f, 1.0f, 0.0f))
  let model = rym * rxm
  result = viewProj * model

proc frame() {.cdecl.} =
  let t: float32 = sapp.frameDuration().float32 * 60.0f
  rx += 1.0f * t
  ry += 2.0f * t

  # the offscreen pass, rendering an rotating, untextured donut into a render target image
  let offscreenVsParams = shd.VsParams(
    mvp: computeMVP(rx, ry, 1.0, 2.5)
  )
  sg.beginPass(offscreenPass)
  sg.applyPipeline(offscreenPip)
  sg.applyBindings(offscreenBindings)
  sg.applyUniforms(shd.ubVsParams.int32, sg.Range(addr: offscreenVsParams.addr, size: offscreenVsParams.sizeof))
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
  sg.applyUniforms(shd.ubVsParams.int32, sg.Range(addr: defaultVsParams.addr, size: offscreenVsParams.sizeof))
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
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
