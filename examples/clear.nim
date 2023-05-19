#-------------------------------------------------------------------------------
# clear.nim
# Clear the framebuffer.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/app as sapp
import sokol/gfx as sg
import sokol/glue as sglue

var passAction = PassAction(
  colors: [ ColorAttachmentAction( loadAction: loadActionClear, clearValue: (1, 0, 0, 0)) ]
)

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    context: sglue.context(),
    logger: sg.Logger(fn: slog.fn),
  ))
  case sg.queryBackend():
    of backendGlcore33: echo "using GLCORE33 backend"
    of backendD3d11: echo "using D3D11 backend"
    of backendMetalMacos: echo "using Metal backend"
    else: echo "using untested backend"

proc frame() {.cdecl.} =
  var g = passAction.colors[0].clearValue.g + 0.01
  passAction.colors[0].clearValue.g = if g > 1.0: 0.0 else: g
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
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn)
))
