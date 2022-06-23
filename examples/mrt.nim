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
    offscreenBindings.fsImages[i] = offscreenPassDesc.colorAttachments[i].image

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

  # a render pass with 3 color attachment images, and a depth attachment image
  createOffscreenPass(sapp.width(), sapp.height())


