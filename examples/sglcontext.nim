#-------------------------------------------------------------------------------
#   sglcontext.nim
#
#   Demonstrates how to render in different render passes with sokol_gl.h
#   using sokol-gl contexts.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sgl
import sokol/glue as sglue
import std/math

const
  offscreenPixelFormat = pixelFormatRGBA8
  offscreenSampleCount = 1
  offscreenWidth = 32
  offscreenHeight = 32
  offscreenPassAction = PassAction(
    colors: [ ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0, 0, 0, 1)) ]
  )
  displayPassAction = PassAction(
    colors: [ ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.5, 0.7, 1.0, 1.0)) ]
  )

var
  offscreenAttachments: Attachments
  offscreenImage: Image
  offscreenContext: sgl.Context
  displaySampler: Sampler
  displayPipeline: sgl.Pipeline

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))
  sgl.setup(sgl.Desc(
    maxVertices: 64,
    maxCommands: 16,
    logger: sgl.Logger(fn: slog.fn),
  ))

  # sgl pipeline for default render pass
  displayPipeline = sgl.contextMakePipeline(sgl.defaultContext(), PipelineDesc(
    cullMode: cullModeBack,
    depth: DepthState(
      writeEnabled: true,
      compare: compareFuncLessEqual
    )
  ))

  # create a sokol/gl context compatible with the offscreen render pass
  # (specific color pixel format, no depth-stencil-surface, no MSAA)
  offscreenContext = sgl.makeContext(sgl.ContextDesc(
    maxVertices: 8,
    maxCommands: 4,
    colorFormat: offscreenPixelFormat,
    depthFormat: pixelFormatNone,
    sampleCount: offscreenSampleCount
  ))

  # create an offscreen render target texture and pass
  offscreenImage = sg.makeImage(sg.ImageDesc(
    usage: ImageUsage(renderAttachment: true),
    width: offscreenWidth,
    height: offscreenHeight,
    pixelFormat: offscreenPixelFormat,
    sampleCount: offscreenSampleCount,
  ))
  offscreenAttachments = sg.makeAttachments(AttachmentsDesc(
    colors: [ AttachmentDesc(image: offscreenImage) ]
  ))

  # create a sampler to sample the offscreen render target as texture
  displaySampler = sg.makeSampler(SamplerDesc(
    wrapU: wrapClampToEdge,
    wrapV: wrapClampToEdge,
    minFilter: filterNearest,
    magFilter: filterNearest
  ))

# helper function to draw a colored quad with sokol-gl
proc drawQuad() =
    sgl.begin_quads()
    sgl.v2fC3b( 0, -1, 255, 0, 0)
    sgl.v2fC3b( 1,  0, 0, 0, 255)
    sgl.v2fC3b( 0,  1, 0, 255, 255)
    sgl.v2fC3b(-1,  0, 0, 255, 0)
    sgl.end()

proc drawCube() =
    sgl.beginQuads()
    sgl.v3fT2f(-1,  1, -1, 0, 1)
    sgl.v3fT2f( 1,  1, -1, 1, 1)
    sgl.v3fT2f( 1, -1, -1, 1, 0)
    sgl.v3fT2f(-1, -1, -1, 0, 0)
    sgl.v3fT2f(-1, -1,  1, 0, 1)
    sgl.v3fT2f( 1, -1,  1, 1, 1)
    sgl.v3fT2f( 1,  1,  1, 1, 0)
    sgl.v3fT2f(-1,  1,  1, 0, 0)
    sgl.v3fT2f(-1, -1,  1, 0, 1)
    sgl.v3fT2f(-1,  1,  1, 1, 1)
    sgl.v3fT2f(-1,  1, -1, 1, 0)
    sgl.v3fT2f(-1, -1, -1, 0, 0)
    sgl.v3fT2f( 1, -1,  1, 0, 1)
    sgl.v3fT2f( 1, -1, -1, 1, 1)
    sgl.v3fT2f( 1,  1, -1, 1, 0)
    sgl.v3fT2f( 1,  1,  1, 0, 0)
    sgl.v3fT2f( 1, -1, -1, 0, 1)
    sgl.v3fT2f( 1, -1,  1, 1, 1)
    sgl.v3fT2f(-1, -1,  1, 1, 0)
    sgl.v3fT2f(-1, -1, -1, 0, 0)
    sgl.v3fT2f(-1,  1, -1, 0, 1)
    sgl.v3fT2f(-1,  1,  1, 1, 1)
    sgl.v3fT2f( 1,  1,  1, 1, 0)
    sgl.v3fT2f( 1,  1, -1, 0, 0)
    sgl.end()

proc frame() {.cdecl.} =
  let t = sapp.frameDuration().float32 * 60
  let a = sgl.asRadians(sapp.frameCount().float32 * t)

  # create an offscreen render target texture, pass, and pass_action
  sgl.setContext(offscreenContext)
  sgl.defaults()
  sgl.matrixModeModelview()
  sgl.rotate(a, 0, 0, 1)
  drawQuad()

  # draw a rotating cube, using the offscreen render target as texture
  sgl.setContext(sgl.defaultContext())
  sgl.defaults()
  sgl.enableTexture()
  sgl.texture(offscreenImage, displaySampler)
  sgl.loadPipeline(displayPipeline)
  sgl.matrixModeProjection()
  sgl.perspective(sgl.asRadians(45), sapp.widthf() / sapp.heightf(), 0.1, 100)
  let eye = [ math.sin(a)*6, math.sin(a)*3, math.cos(a)*6 ]
  sgl.matrixModeModelview()
  sgl.lookat(eye[0], eye[1], eye[2], 0, 0, 0, 0, 1, 0)
  drawCube()

  # do the actual offscreen and display rendering in sokol/gfx passes
  sg.beginPass(Pass(action: offscreenPassAction, attachments: offscreenAttachments))
  sgl.contextDraw(offscreenContext)
  sg.endPass()
  sg.beginPass(Pass(action: displayPassAction, swapchain: sglue.swapchain()))
  sgl.contextDraw(sgl.defaultContext())
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sgl.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 800,
  height: 600,
  sampleCount: 4,
  windowTitle: "sglcontext.nim",
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
