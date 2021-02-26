# Sokol app/gfx glue -----------------------------------------------------------

import "../gfx"

proc gfxContext*():gfx.ContextDesc {.cdecl, importc:"sapp_sgcontext".}

# Syntax sugar for Nim ---------------------------------------------------------

var cleanup*: proc ()

var event*: proc (e: Event)

var fail*: proc (s: string)

var frame*: proc ()

proc app_onInit() {.cdecl, exportc.} =
  proc NimMain() {.importc.}
  NimMain()

proc app_onCleanup() {.cdecl, exportc.} =
  if cleanup != nil: cleanup()

proc app_onEvent(e: ptr Event) {.cdecl, exportc.} =
  if event != nil: event(e[])

proc app_onFail(s: cstring) {.cdecl, exportc.} =
  if fail != nil: fail($s)

proc app_onFrame() {.cdecl, exportc.} =
  if frame != nil: frame()

# Graphics backend selection ---------------------------------------------------

when defined(gl):
  const gl*    = true
  const d3d11* = false
  const metal* = false
elif defined(windows):
  const gl*    = false
  const d3d11* = true
  const metal* = false
elif defined(macosx):
  const gl*    = false
  const d3d11* = false
  const metal* = true
elif defined(ios):
  const gl*    = false
  const d3d11* = false
  const metal* = true

# Platform specific compilation ------------------------------------------------

when defined(windows):
  {.passl:"-lgdi32 -lshell32 -luser32".}
  when defined(gl):
    {.passc:"-DSOKOL_GLCORE33".}
  else:
    {.passc:"-DSOKOL_D3D11".}
    {.passl:"-ld3d11 -ldxgi -ldxguid".}
elif defined(macosx):
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
  when defined(gl):
    {.passc:"-DSOKOL_GLCORE33".}
    {.passl:"-framework OpenGL".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
elif defined(ios):
  {.passc:"-x objective-c".}
  {.passl:"-framework Foundation -framework UIKit".}
  when defined(gl):
    {.passc:"-DSOKOL_GLES3".}
    {.passl:"-framework OpenGLES -framework GLKit".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
else:
  {.passc:"-DSOKOL_GLCORE33".}
  {.passl:"-lX11 -lXi -lXcursor -lGL -ldl -lpthread -lm".}

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_IMPL".}
{.compile:"../c/sokol_app_gfx.c".}