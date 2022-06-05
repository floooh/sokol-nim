# Graphics backend selection ---------------------------------------------------

when defined gl:
  const gl*    = true
  const d3d11* = false
  const metal* = false
elif defined windows:
  const gl*    = false
  const d3d11* = true
  const metal* = false
elif defined macosx:
  const gl*    = false
  const d3d11* = false
  const metal* = true
elif defined ios:
  const gl*    = false
  const d3d11* = false
  const metal* = true
elif defined linux:
  const gl*    = true
  const d3d11* = false
  const metal* = false
else:
  error("unsupported platform")

# Platform specific compilation ------------------------------------------------

when defined windows:
  {.passl:"-lgdi32 -lshell32 -luser32".}
elif defined macosx:
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
elif defined ios:
  {.passc:"-x objective-c".}
  {.passl:"-framework Foundation -framework UIKit".}
elif defined linux:
  {.passl:"-lX11 -lXi -lXcursor -ldl -lpthread -lm".}
else:
  error("unsupported platform")

# Entry template ---------------------------------------------------------------

proc NimMain() {.importc.}

template sokolMain*(desc: untyped, body: untyped) =
  proc sokol_main*(argc: cint, argv: ptr cstring): Desc {.cdecl, exportc:"sokol_main".} =
    NimMain()
    var desc: Desc
    body
    return desc

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"../c/sokol_app.c".}
