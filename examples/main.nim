#-------------------------------------------------------------------------------
# example sokol_app entry point via sokol_main
#-------------------------------------------------------------------------------

import sokol/app

var cleanup*: proc()

var event*: proc(e: Event)

var fail*: proc(s: string)

var frame*: proc()

proc sokol_main():app.Desc {.cdecl, exportc:"sokol_main".} =
  proc NimMain() {.importc.}
  app.Desc(
    # callbacks
    initCb:(proc() {.cdecl.} =
      NimMain() # execute Nim module-level statements
    ),
    cleanupCb:(proc() {.cdecl.} =
      if cleanup != nil: cleanup()
    ),
    frameCb:(proc() {.cdecl.} =
      if frame != nil: frame()
    ),
    eventCb:(proc(e: ptr Event) {.cdecl.} =
      if event != nil: event(e[])
    ),
    failCb:(proc(s: cstring) {.cdecl.} =
      if fail != nil: fail($s)
    ),

    # settings
    highDpi: true,
    windowTitle: "sokol nim example",
    win32ConsoleAttach: true,
    win32ConsoleUtf8: true,
  )
