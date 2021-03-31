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
elif defined(linux):
  const gl*    = true
  const d3d11* = false
  const metal* = false
else:
  error("unsupported platform")

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
elif defined(linux):
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
converter toRange*[T](source:var T):Range =
  Range(source:addr(source), size:sizeof(source))

# Accept partial initialization of arrays

converter toColorAttachmentActions*[N:static[int]](
  actions:array[N, ColorAttachmentAction]
):array[MAX_COLOR_ATTACHMENTS, ColorAttachmentAction] =
  static: assert(N <= MAX_COLOR_ATTACHMENTS)
  for i,action in actions.pairs: result[i] = action

converter toShaderUniformBlockDescs*[N:static[int]](
  descs:array[N, ShaderUniformBlockDesc]
):array[MAX_SHADERSTAGE_UBS, ShaderUniformBlockDesc] =
  static: assert(N <= MAX_SHADERSTAGE_UBS)
  for i,desc in descs.pairs: result[i] = desc

converter toShaderUniformDescs*[N:static[int]](
  descs:array[N, ShaderUniformDesc]
):array[MAX_UB_MEMBERS, ShaderUniformDesc] =
  static: assert(N <= MAX_UB_MEMBERS)
  for i,desc in descs.pairs: result[i] = desc

converter toBufferLayoutDescs*[N:static[int]](
  descs:array[N, BufferLayoutDesc]
):array[MAX_SHADERSTAGE_BUFFERS, BufferLayoutDesc] =
  static: assert(N <= MAX_SHADERSTAGE_BUFFERS)
  for i,desc in descs.pairs: result[i] = desc

converter toVertexAttrDescs*[N:static[int]](
  descs:array[N, VertexAttrDesc]
):array[MAX_VERTEX_ATTRIBUTES, VertexAttrDesc] =
  static: assert(N <= MAX_VERTEX_ATTRIBUTES)
  for i,desc in descs.pairs: result[i] = desc

converter toShaderAttrDescs*[N:static[int]](
  descs:array[N, ShaderAttrDesc]
):array[MAX_VERTEX_ATTRIBUTES, ShaderAttrDesc] =
  static: assert(N <= MAX_VERTEX_ATTRIBUTES)
  for i,desc in descs.pairs: result[i] = desc

converter toBuffers*[N:static[int]](
  descs:array[N, Buffer]
):array[MAX_SHADERSTAGE_BUFFERS, Buffer] =
  static: assert(N <= MAX_SHADERSTAGE_BUFFERS)
  for i,desc in descs.pairs: result[i] = desc

converter toImages*[N:static[int]](
  images:array[N, ShaderImageDesc]
):array[MAX_SHADERSTAGE_IMAGES, ShaderImageDesc] =
  static: assert(N <= MAX_SHADERSTAGE_IMAGES)
  for i,image in images.pairs: result[i] = image

converter toImages*[N:static[int]](
  images:array[N, Image]
):array[MAX_SHADERSTAGE_IMAGES, Image] =
  static: assert(N <= MAX_SHADERSTAGE_IMAGES)
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
):array[MAX_COLOR_ATTACHMENTS, ColorState] =
  static: assert(N <= MAX_COLOR_ATTACHMENTS)
  for i,image in images.pairs: result[i] = image

# Accept various pointers by value ---------------------------------------------

proc setup*(desc:Desc) =
  setup(unsafeAddr(desc))

proc makeBuffer*(desc:BufferDesc):Buffer =
  makeBuffer(unsafeAddr(desc))

proc makeImage*(desc:ImageDesc):Image =
  makeImage(unsafeAddr(desc))

proc makeShader*(desc:ShaderDesc):Shader =
  makeShader(unsafeAddr(desc))

proc makePipeline*(desc:PipelineDesc):Pipeline =
  makePipeline(unsafeAddr(desc))

proc makePass*(desc:PassDesc):Pass =
  makePass(unsafeAddr(desc))

proc updateBuffer*(buf:Buffer; data:Range) =
  updateBuffer(buf, unsafeAddr(data))

proc updateImage*(img:Image; data:ImageData) =
  updateImage(img, unsafeAddr(data))

proc appendBuffer*(buf:Buffer; data:Range):cint =
  appendBuffer(buf, unsafeAddr(data))

proc beginDefaultPass*(passAction:PassAction; width:cint; height:cint) =
  beginDefaultPass(unsafeAddr(passAction), width, height)

proc beginDefaultPassf*(passAction:PassAction; width:cfloat; height:cfloat) =
  beginDefaultPassf(unsafeAddr(passAction), width, height)

proc beginPass*(pass:Pass; passAction:PassAction) =
  beginPass(pass, unsafeAddr(passAction))

proc applyBindings*(bindings:Bindings) =
  applyBindings(unsafeAddr(bindings))

proc applyUniforms*(stage:ShaderStage; ubIndex:cint; data:Range) =
  applyUniforms(stage, ubIndex, unsafeAddr(data))

proc queryBufferDefaults*(desc:BufferDesc):BufferDesc =
  queryBufferDefaults(unsafeAddr(desc))

proc queryImageDefaults*(desc:ImageDesc):ImageDesc =
  queryImageDefaults(unsafeAddr(desc))

proc queryShaderDefaults*(desc:ShaderDesc):ShaderDesc =
  queryShaderDefaults(unsafeAddr(desc))

proc queryPipelineDefaults*(desc:PipelineDesc):PipelineDesc =
  queryPipelineDefaults(unsafeAddr(desc))

proc queryPassDefaults*(desc:PassDesc):PassDesc =
  queryPassDefaults(unsafeAddr(desc))

proc initBuffer*(bufId:Buffer; desc:BufferDesc) =
  initBuffer(bufId, unsafeAddr(desc))

proc initImage*(imgId:Image; desc:ImageDesc) =
  initImage(imgId, unsafeAddr(desc))

proc initShader*(shdId:Shader; desc:ShaderDesc) =
  initShader(shdId, unsafeAddr(desc))

proc initPipeline*(pipId:Pipeline; desc:PipelineDesc) =
  initPipeline(pipId, unsafeAddr(desc))

proc initPass*(passId:Pass; desc:PassDesc) =
  initPass(passId, unsafeAddr(desc))

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_IMPL".}
{.compile:"../c/sokol_gfx.c".}