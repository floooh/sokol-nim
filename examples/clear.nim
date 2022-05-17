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

sokolMain(desc):
  desc.initCb = init
  desc.eventCb = event
  desc.frameCb = frame
  desc.cleanupCb = cleanup
  desc.failCb = fail

  desc.windowTitle = "clear"
  desc.width = 400
  desc.height = 300
  desc.highDpi = true
  desc.win32ConsoleAttach = true
  desc.win32ConsoleUtf8 = true
