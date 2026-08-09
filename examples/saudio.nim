#-------------------------------------------------------------------------------
#   saudio.nim
#   Test sokol-audio
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/app as sapp
import sokol/gfx as sg
import sokol/audio as soaudio #soaudo so the module is not called the same as the alias
import sokol/glue as sglue

const
  numSamples = 32

let passAction = block:
  var p = PassAction()
  p.colors[0] = ColorAttachmentAction(loadAction: loadActionClear, clearValue: (1, 0.5, 0, 1))
  p

var
  evenOdd: uint32
  samplePos: int32
  samples: array[numSamples, float32]

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  soaudio.setup(soaudio.Desc(
    logger: soaudio.Logger(fn: slog.fn)
  ))

proc frame() {.cdecl.} =
  # feed sokol/audio
  let numFrames = soaudio.expect()
  for i in 0..<numFrames:
    let sampleVal = if 0 == (evenOdd and (1u32 shl 5)): 0.05f else: -0.05f
    samples[samplePos] = sampleVal
    evenOdd += 1
    samplePos += 1
    if samplePos == numSamples:
      samplePos = 0
      discard soaudio.push(addr(samples[0]), 32)
  # render a cleared framebuffer
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  soaudio.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 400,
  height: 300,
  windowTitle: "saudio.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
