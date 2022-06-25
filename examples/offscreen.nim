#-------------------------------------------------------------------------------
#   offscreen.nim
#   Render to an offscreen rendertarget texture, and use this texture
#   for rendering to the display.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/shape as sshape
import sokol/glue
import math/vec3
import math/mat4
import shaders/offscreen as shd

const
  offscreenSampleCount = 4

var
  offscreenPassAction: PassAction
  offscreenPass: Pass
  offscreenPip: Pipeline
  offscreenBindings: Bindings
  defaultPassAction: PassAction
  defaultPip: Pipeline
  defaultBindings: Bindings
  donut, sphere: sshape.ElementRange
  rx, ry: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc( context: glue.context() ))

  # default pass action: clear to blue-ish
  defaultPassAction = PassAction(
    colors: [ ColorAttachmentAction( action: actionClear, value: (0.25, 0.45, 0.65, 1 )) ]
  )

  # offscreen pass action: clear to grey
  offscreenPassAction = PassAction(
    colors: [ ColorAttachmentAction( action: actionClear, value: (0.25, 0.25, 0.25, 1 )) ]
  )

  # a render pass with one color- and one depth-attachment image
  var imgDesc = sg.ImageDesc(
    renderTarget: true,
    width: 256,
    height: 256,
    pixelFormat: pixelFormatRgba8,
    minFilter: filterLinear,
    magFilter: filterLinear,
    wrapU: wrapRepeat,
    wrapV: wrapRepeat,
    sampleCount: offscreenSampleCount,
  )
  let colorImg = sg.makeImage(imgDesc)
  imgDesc.pixelFormat = pixelFormatDepth
  let depthImg = sg.makeImage(imgDesc)
  offscreenPass = sg.makePass(PassDesc(
    colorAttachments: [ PassAttachmentDesc(image: colorImg) ],
    depthStencilAttachment: PassAttachmentDesc(image: depthImg)
  ))

  # a donut shape which is rendered into the offscreen render target, and
  # a sphere shape which is rendered into the default framebuffer
  var vertices: array[4000, sshape.Vertex]
  var indices: array[24000, uint16]
  var buf = sshape.Buffer(
    vertices: BufferItem(buffer: vertices),
    indices: BufferItem(buffer: indices)
  )
  buf = sshape.buildTorus(buf, Torus(radius:0.5, ringRadius:0.3, sides:20, rings:36))
  donut = sshape.elementRange(buf)
  buf = sshape.buildSphere(buf, Sphere(radius:0.5, slices: 72, stacks: 40))
  sphere = sshape.elementRange(buf)

  let vbuf = sg.makeBuffer(sshape.vertexBufferDesc(buf))
  let ibuf = sg.makeBuffer(sshape.indexBufferDesc(buf))

  # pipeline object for offscreen-rendered donut, don't need vertex coords here
  offscreenPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(offscreenShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      buffers: [ sshape.bufferLayoutDesc() ],
      attrs: [
        sshape.positionAttrDesc(),
        sshape.normalAttrDesc()
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
      ColorState(pixelFormat: pixelFormatRgba8)
    ]
  ))

  # ...and another pipeline object for the default pass
  defaultPip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(defaultShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      buffers: [ sshape.bufferLayoutDesc() ],
      attrs: [
        sshape.positionAttrDesc(),
        sshape.normalAttrDesc(),
        sshape.texcoordAttrDesc()
      ]
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeBack,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true,
    )
  ))

  # the resource bindings for rendering a non-textured cube into offscreen render target
  offscreenBindings = Bindings(
    vertexBuffers: [ vbuf ],
    indexBuffer: ibuf,
  )

  # resource bindings to render a textured cube, using the offscreen render target as texture
  defaultBindings = Bindings(
     vertexBuffers: [ vbuf ],
     indexBuffer: ibuf,
     fsImages: [ colorImg ]
  )

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
  sg.beginPass(offscreenPass, offscreenPassAction)
  sg.applyPipeline(offscreenPip)
  sg.applyBindings(offscreenBindings)
  sg.applyUniforms(shaderStageVs, shd.slotVsParams, offscreenVsParams)
  sg.draw(donut.baseElement, donut.numElements, 1)
  sg.endPass()

  # and the display-pass, rendering a rotating textured sphere which uses the
  # previously rendered offscreen render-target as texture
  let defaultVsParams = shd.VsParams(
    mvp: computeMVP(-rx * 0.25, ry * 0.25, sapp.widthf()/sapp.heightf(), 2.0)
  )
  sg.beginDefaultPass(defaultPassAction, sapp.width(), sapp.height())
  sg.applyPipeline(defaultPip)
  sg.applyBindings(defaultBindings)
  sg.applyUniforms(shaderStageVs, shd.slotVsParams, defaultVsParams)
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
  windowTitle: "offscreen.nim"
))
