#-------------------------------------------------------------------------------
#   saudio.nim
#   Test sokol-audio
#-------------------------------------------------------------------------------
import sokol/app as sapp
import sokol/gfx as sg
import sokol/audio as saudio
import sokol/glue as sglue

const
  numSamples = 32
  passAction = PassAction(
    colors: [ ColorAttachmentAction(action: actionClear, value: (1, 0.5, 0, 1)) ]
  )

var
  evenOdd: uint32
  samplePos: int
  samples: array[numSamples, float32]

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))
  saudio.setup(saudio.Desc())

proc frame() {.cdecl.} =
  # feed sokol/audio
  let numFrames = saudio.expect()
  for i in 0..<numFrames:
    samples[samplePos] = if 0 == (evenOdd and (1 shl 5)): 0.05 else: -0.05
    evenOdd += 1
    samplePos += 1
    if samplePos == numSamples:
      samplePos = 0
      discard saudio.push(addr(samples[0]), 32)
  # render a cleared framebuffer
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  saudio.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 400,
  height: 300,
  windowTitle: "saudio.nim"
))
