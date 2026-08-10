#-------------------------------------------------------------------------------
#   debugtextprintf.nim
#
#   How to do formatted printing with sokol/debugtext
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/debugtext as sdtx
import sokol/glue as sglue

import std/strutils

when defined(nimony):
  template asCString(s: var string): cstring = s.toCString()
else:
  template asCString(s: var string): cstring = s.cstring

type Color = object
  r, g, b: uint8

let
  numFonts = 3
  passAction = block:
    var p = PassAction()
    p.colors[0] = ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0, 0.125, 0.25, 1))
    p
  palette = [
    Color(r:0xf4, g:0x43, b:0x36),
    Color(r:0x21, g:0x96, b:0xf3),
    Color(r:0x4c, g:0xaf, b:0x50)
  ]

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))
  sdtx.setup:
    var d = sdtx.Desc(
      logger: sdtx.Logger(fn: slog.fn),
    )
    let fonts = [
      sdtx.fontKc854(),
      sdtx.fontC64(),
      sdtx.fontOric()
    ]
    for i in 0..<fonts.len:
      d.fonts[i] = fonts[i]
    d

proc frame() {.cdecl.} =
  let frameCount = sapp.frameCount()
  let frameTime = sapp.frameDuration() * 1000

  sdtx.canvas(sapp.widthf() * 0.5, sapp.heightf() * 0.5)
  sdtx.origin(3, 3)
  for i in 0..<numFonts:
    let color = palette[i]
    let str = if (frameCount and (1u64 shl 7u64)) == 0: "Welt" else: "World"
    sdtx.font(i.int32)
    sdtx.color3b(color.r, color.g, color.b)
    var s1, s2, s3: string
    s1 = "Hello '" & str & "'!\n"
    s2 = "\tFrame Time:\t\t" & frameTime.formatFloat(ffDecimal, 3) & "\n"
    s3 = "\tFrame Count:\t" & $frameCount & "\t0x" & frameCount.toHex() & "\n"

    sdtx.puts(s1.asCString())
    sdtx.puts(s2.asCString())
    sdtx.puts(s3.asCString())
    sdtx.putr("Range Test 1 (xyzbla)", 12)
    sdtx.putr("\nRange Test 2\n", 32)
    sdtx.moveY(2)
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  sdtx.draw()
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sdtx.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 640,
  height: 480,
  windowTitle: "debugtextprintf.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
