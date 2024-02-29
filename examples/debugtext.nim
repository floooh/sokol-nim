#-------------------------------------------------------------------------------
#   debugtext-sapp.c
#   Text rendering with sokol_debugtext.h, test builtin fonts.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/debugtext as sdtx
import sokol/glue as sglue

const passAction = PassAction(
  colors: [
    ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0, 0.125, 0.25, 1))
  ]
)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))

  # setup sokol/debugtext
  sdtx.setup(sdtx.Desc(
    fonts: [
      sdtx.fontKc853(),
      sdtx.fontKc854(),
      sdtx.fontZ1013(),
      sdtx.fontCpc(),
      sdtx.fontC64(),
      sdtx.fontOric()
    ],
    logger: sdtx.Logger(fn: slog.fn),
  ))

proc printFont(fontIndex: int32, title: cstring, r: uint8, g: uint8, b: uint8) =
  sdtx.font(fontIndex)
  sdtx.color3b(r, g, b)
  sdtx.puts(title)
  for c in 32..<256:
    sdtx.putc(c.char)
    if 0 == ((c + 1) and 63):
      sdtx.crlf()
  sdtx.crlf()

proc frame() {.cdecl.} =
    # set virtual canvas size to half display size so that
    # glyphs are 16x16 display pixels
    sdtx.canvas(sapp.widthf()*0.5, sapp.heightf()*0.5)
    sdtx.origin(0, 2)
    sdtx.home()
    print_font(0, "KC85/3:\n",      0xf4, 0x43, 0x36)
    print_font(1, "KC85/4:\n",      0x21, 0x96, 0xf3)
    print_font(2, "Z1013:\n",       0x4c, 0xaf, 0x50)
    print_font(3, "Amstrad CPC:\n", 0xff, 0xeb, 0x3b)
    print_font(4, "C64:\n",         0x79, 0x86, 0xcb)
    print_font(5, "Oric Atmos:\n",  0xff, 0x98, 0x00)

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
  width: 1024,
  height: 600,
  windowTitle: "debugtext.nim",
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
