#-------------------------------------------------------------------------------
# clear.nim
# Clear the framebuffer.
#-------------------------------------------------------------------------------

import sokol/[app,gfx,glue]

var passAction = PassAction(
  colors: [
    ColorAttachmentAction(
      action: Action.clear,
      value: (1, 0, 0, 0),
    ),
  ]
)

proc init() {.cdecl.} =
  setup(gfx.Desc(context: context()))

proc event(e: ptr app.Event) {.cdecl.} =
  echo e.type

proc frame() {.cdecl.} =
  var g = passAction.colors[0].value.g + 0.01
  passAction.colors[0].value.g = if g > 1.0: 0.0 else: g
  beginDefaultPass(passAction, app.width(), app.height())
  endPass()
  commit()

proc cleanup() {.cdecl.} =
  shutdown()

proc fail(reason: cstring) {.cdecl.} =
  echo "sokol error: ", reason

app.run(app.Desc(
  initCb: init,
  eventCb: event,
  frameCb: frame,
  cleanupCb: cleanup,
  failCb: fail,
  windowTitle: "clear.nim",
  width: 400,
  height: 300,
))
