#-------------------------------------------------------------------------------
# clear.nim
# Clear the framebuffer.
#-------------------------------------------------------------------------------
import sokol/app as sapp
import sokol/gfx as sg
import sokol/glue as glue

var passAction = PassAction(
  colors: [ ColorAttachmentAction( action: actionClear, value: (1, 0, 0, 0)) ]
)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: glue.context()))

proc frame() {.cdecl.} =
  var g = passAction.colors[0].value.g + 0.01
  passAction.colors[0].value.g = if g > 1.0: 0.0 else: g
  beginDefaultPass(passAction, sapp.width(), sapp.height())
  endPass()
  commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  windowTitle: "clear.nim",
  width: 400,
  height: 300,
))
