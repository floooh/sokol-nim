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

# Accept partial initialization of arrays

converter toColorAttachmentActions*[N:static[int]](
  actions:array[N, ColorAttachmentAction]
):array[maxColorAttachments, ColorAttachmentAction] =
  static: assert(N <= maxColorAttachments)
  for i,action in actions.pairs: result[i] = action

converter toShaderUniformBlockDescs*[N:static[int]](
  descs:array[N, ShaderUniformBlockDesc]
):array[maxShaderstageUbs, ShaderUniformBlockDesc] =
  static: assert(N <= maxShaderstageUbs)
  for i,desc in descs.pairs: result[i] = desc

converter toShaderUniformDescs*[N:static[int]](
  descs:array[N, ShaderUniformDesc]
):array[maxUbMembers, ShaderUniformDesc] =
  static: assert(N <= maxUbMembers)
  for i,desc in descs.pairs: result[i] = desc

converter toBufferLayoutDescs*[N:static[int]](
  descs:array[N, BufferLayoutDesc]
):array[maxShaderStageBuffers, BufferLayoutDesc] =
  static: assert(N <= maxShaderStageBuffers)
  for i,desc in descs.pairs: result[i] = desc

converter toVertexAttrDescs*[N:static[int]](
  descs:array[N, VertexAttrDesc]
):array[maxVertexAttributes, VertexAttrDesc] =
  static: assert(N <= maxVertexAttributes)
  for i,desc in descs.pairs: result[i] = desc

converter toShaderAttrDescs*[N:static[int]](
  descs:array[N, ShaderAttrDesc]
):array[maxVertexAttributes, ShaderAttrDesc] =
  static: assert(N <= maxVertexAttributes)
  for i,desc in descs.pairs: result[i] = desc

converter toBuffers*[N:static[int]](
  descs:array[N, Buffer]
):array[maxShaderStageBuffers, Buffer] =
  static: assert(N <= maxShaderStageBuffers)
  for i,desc in descs.pairs: result[i] = desc

converter toImages*[N:static[int]](
  images:array[N, ShaderImageDesc]
):array[maxShaderstageImages, ShaderImageDesc] =
  static: assert(N <= maxShaderstageImages)
  for i,image in images.pairs: result[i] = image

converter toImages*[N:static[int]](
  images:array[N, Image]
):array[maxShaderstageImages, Image] =
  static: assert(N <= maxShaderstageImages)
  for i,image in images.pairs: result[i] = image

converter toImageData*[N:static[int], M:static[int]](
  layers:array[N, array[M, Range]]
):ImageData =
  static:
    assert(N <= ord(CubeFace.Num))
    assert(M <= MAX_MIPMAPS)
  for i,layer in layers:
    for j,image in layer:
      result.subimage[i][j] = image

converter toColors*[N:static[int]](
  images:array[N, ColorState]
):array[maxColorAttachments, ColorState] =
  static: assert(N <= maxColorAttachments)
  for i,image in images.pairs: result[i] = image

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"../c/sokol_gfx.c".}
