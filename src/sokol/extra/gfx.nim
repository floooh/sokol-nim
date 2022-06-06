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
  when defined gl:
    {.passc:"-DSOKOL_GLCORE33".}
  else:
    {.passc:"-DSOKOL_D3D11".}
    {.passl:"-ld3d11 -ldxgi -ldxguid".}
elif defined macosx:
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE33".}
    {.passl:"-framework OpenGL".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
elif defined ios:
  {.passc:"-x objective-c".}
  {.passl:"-framework Foundation -framework UIKit".}
  when defined gl:
    {.passc:"-DSOKOL_GLES3".}
    {.passl:"-framework OpenGLES -framework GLKit".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
elif defined linux:
  {.passc:"-DSOKOL_GLCORE33".}
  {.passl:"-lX11 -lXi -lXcursor -lGL -ldl -lpthread -lm".}
else:
  error("unsupported platform")

# Conversions ------------------------------------------------------------------

## Convert a 4-element tuple of numbers to a gfx.Color
converter toColor*[
  R:SomeNumber,
  G:SomeNumber,
  B:SomeNumber,
  A:SomeNumber
](rgba: tuple [r:R,g:G,b:B,a:A]):Color =
  ## accept any tuple of 4 numbers for Color
  Color(
    r:rgba.r.float32,
    g:rgba.g.float32,
    b:rgba.b.float32,
    a:rgba.a.float32,
  )

## Convert a 3-element tuple of numbers to a gfx.Color with alpha 1f
converter toColor*[
  R:SomeNumber,
  G:SomeNumber,
  B:SomeNumber
](rgba: tuple [r:R,g:G,b:B]):Color =
  ## accept any tuple of 4 numbers for Color
  Color(
    r:rgba.r.float32,
    g:rgba.g.float32,
    b:rgba.b.float32,
    a:1.float32,
  )

##  Convert any variable to a Range
converter toRange*[T](source: T): Range =
  Range(`ptr`: source.unsafeAddr, size: source.sizeof.uint)

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"../c/sokol_gfx.c".}
