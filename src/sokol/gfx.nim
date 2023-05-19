## machine generated, do not edit


type Buffer* = object
  id*:uint32

type Image* = object
  id*:uint32

type Shader* = object
  id*:uint32

type Pipeline* = object
  id*:uint32

type Pass* = object
  id*:uint32

type Context* = object
  id*:uint32

type Range* = object
  `addr`*:pointer
  size*:int

const
  invalidId* = 0
  numShaderStages* = 2
  numInflightFrames* = 2
  maxColorAttachments* = 4
  maxShaderstageBuffers* = 8
  maxShaderstageImages* = 12
  maxShaderstageUbs* = 4
  maxUbMembers* = 16
  maxVertexAttributes* = 16
  maxMipmaps* = 16
  maxTexturearrayLayers* = 128

type Color* = object
  r*:float32
  g*:float32
  b*:float32
  a*:float32

type
  Backend* {.size:sizeof(int32).} = enum
    backendGlcore33,
    backendGles3,
    backendD3d11,
    backendMetalIos,
    backendMetalMacos,
    backendMetalSimulator,
    backendWgpu,
    backendDummy,

type
  PixelFormat* {.size:sizeof(int32).} = enum
    pixelFormatDefault,
    pixelFormatNone,
    pixelFormatR8,
    pixelFormatR8sn,
    pixelFormatR8ui,
    pixelFormatR8si,
    pixelFormatR16,
    pixelFormatR16sn,
    pixelFormatR16ui,
    pixelFormatR16si,
    pixelFormatR16f,
    pixelFormatRg8,
    pixelFormatRg8sn,
    pixelFormatRg8ui,
    pixelFormatRg8si,
    pixelFormatR32ui,
    pixelFormatR32si,
    pixelFormatR32f,
    pixelFormatRg16,
    pixelFormatRg16sn,
    pixelFormatRg16ui,
    pixelFormatRg16si,
    pixelFormatRg16f,
    pixelFormatRgba8,
    pixelFormatSrgb8a8,
    pixelFormatRgba8sn,
    pixelFormatRgba8ui,
    pixelFormatRgba8si,
    pixelFormatBgra8,
    pixelFormatRgb10a2,
    pixelFormatRg11b10f,
    pixelFormatRg32ui,
    pixelFormatRg32si,
    pixelFormatRg32f,
    pixelFormatRgba16,
    pixelFormatRgba16sn,
    pixelFormatRgba16ui,
    pixelFormatRgba16si,
    pixelFormatRgba16f,
    pixelFormatRgba32ui,
    pixelFormatRgba32si,
    pixelFormatRgba32f,
    pixelFormatDepth,
    pixelFormatDepthStencil,
    pixelFormatBc1Rgba,
    pixelFormatBc2Rgba,
    pixelFormatBc3Rgba,
    pixelFormatBc4R,
    pixelFormatBc4Rsn,
    pixelFormatBc5Rg,
    pixelFormatBc5Rgsn,
    pixelFormatBc6hRgbf,
    pixelFormatBc6hRgbuf,
    pixelFormatBc7Rgba,
    pixelFormatPvrtcRgb2bpp,
    pixelFormatPvrtcRgb4bpp,
    pixelFormatPvrtcRgba2bpp,
    pixelFormatPvrtcRgba4bpp,
    pixelFormatEtc2Rgb8,
    pixelFormatEtc2Rgb8a1,
    pixelFormatEtc2Rgba8,
    pixelFormatEtc2Rg11,
    pixelFormatEtc2Rg11sn,
    pixelFormatRgb9e5,

type PixelformatInfo* = object
  sample*:bool
  filter*:bool
  render*:bool
  blend*:bool
  msaa*:bool
  depth*:bool

type Features* = object
  originTopLeft*:bool
  imageClampToBorder*:bool
  mrtIndependentBlendState*:bool
  mrtIndependentWriteMask*:bool

type Limits* = object
  maxImageSize2d*:int32
  maxImageSizeCube*:int32
  maxImageSize3d*:int32
  maxImageSizeArray*:int32
  maxImageArrayLayers*:int32
  maxVertexAttrs*:int32
  glMaxVertexUniformVectors*:int32
  glMaxCombinedTextureImageUnits*:int32

type
  ResourceState* {.size:sizeof(int32).} = enum
    resourceStateInitial,
    resourceStateAlloc,
    resourceStateValid,
    resourceStateFailed,
    resourceStateInvalid,

type
  Usage* {.size:sizeof(int32).} = enum
    usageDefault,
    usageImmutable,
    usageDynamic,
    usageStream,

type
  BufferType* {.size:sizeof(int32).} = enum
    bufferTypeDefault,
    bufferTypeVertexBuffer,
    bufferTypeIndexBuffer,

type
  IndexType* {.size:sizeof(int32).} = enum
    indexTypeDefault,
    indexTypeNone,
    indexTypeUint16,
    indexTypeUint32,

type
  ImageType* {.size:sizeof(int32).} = enum
    imageTypeDefault,
    imageType2d,
    imageTypeCube,
    imageType3d,
    imageTypeArray,

type
  SamplerType* {.size:sizeof(int32).} = enum
    samplerTypeDefault,
    samplerTypeFloat,
    samplerTypeSint,
    samplerTypeUint,

type
  CubeFace* {.size:sizeof(int32).} = enum
    cubeFacePosX,
    cubeFaceNegX,
    cubeFacePosY,
    cubeFaceNegY,
    cubeFacePosZ,
    cubeFaceNegZ,

type
  ShaderStage* {.size:sizeof(int32).} = enum
    shaderStageVs,
    shaderStageFs,

type
  PrimitiveType* {.size:sizeof(int32).} = enum
    primitiveTypeDefault,
    primitiveTypePoints,
    primitiveTypeLines,
    primitiveTypeLineStrip,
    primitiveTypeTriangles,
    primitiveTypeTriangleStrip,

type
  Filter* {.size:sizeof(int32).} = enum
    filterDefault,
    filterNearest,
    filterLinear,
    filterNearestMipmapNearest,
    filterNearestMipmapLinear,
    filterLinearMipmapNearest,
    filterLinearMipmapLinear,

type
  Wrap* {.size:sizeof(int32).} = enum
    wrapDefault,
    wrapRepeat,
    wrapClampToEdge,
    wrapClampToBorder,
    wrapMirroredRepeat,

type
  BorderColor* {.size:sizeof(int32).} = enum
    borderColorDefault,
    borderColorTransparentBlack,
    borderColorOpaqueBlack,
    borderColorOpaqueWhite,

type
  VertexFormat* {.size:sizeof(int32).} = enum
    vertexFormatInvalid,
    vertexFormatFloat,
    vertexFormatFloat2,
    vertexFormatFloat3,
    vertexFormatFloat4,
    vertexFormatByte4,
    vertexFormatByte4n,
    vertexFormatUbyte4,
    vertexFormatUbyte4n,
    vertexFormatShort2,
    vertexFormatShort2n,
    vertexFormatUshort2n,
    vertexFormatShort4,
    vertexFormatShort4n,
    vertexFormatUshort4n,
    vertexFormatUint10N2,
    vertexFormatHalf2,
    vertexFormatHalf4,

type
  VertexStep* {.size:sizeof(int32).} = enum
    vertexStepDefault,
    vertexStepPerVertex,
    vertexStepPerInstance,

type
  UniformType* {.size:sizeof(int32).} = enum
    uniformTypeInvalid,
    uniformTypeFloat,
    uniformTypeFloat2,
    uniformTypeFloat3,
    uniformTypeFloat4,
    uniformTypeInt,
    uniformTypeInt2,
    uniformTypeInt3,
    uniformTypeInt4,
    uniformTypeMat4,

type
  UniformLayout* {.size:sizeof(int32).} = enum
    uniformLayoutDefault,
    uniformLayoutNative,
    uniformLayoutStd140,

type
  CullMode* {.size:sizeof(int32).} = enum
    cullModeDefault,
    cullModeNone,
    cullModeFront,
    cullModeBack,

type
  FaceWinding* {.size:sizeof(int32).} = enum
    faceWindingDefault,
    faceWindingCcw,
    faceWindingCw,

type
  CompareFunc* {.size:sizeof(int32).} = enum
    compareFuncDefault,
    compareFuncNever,
    compareFuncLess,
    compareFuncEqual,
    compareFuncLessEqual,
    compareFuncGreater,
    compareFuncNotEqual,
    compareFuncGreaterEqual,
    compareFuncAlways,

type
  StencilOp* {.size:sizeof(int32).} = enum
    stencilOpDefault,
    stencilOpKeep,
    stencilOpZero,
    stencilOpReplace,
    stencilOpIncrClamp,
    stencilOpDecrClamp,
    stencilOpInvert,
    stencilOpIncrWrap,
    stencilOpDecrWrap,

type
  BlendFactor* {.size:sizeof(int32).} = enum
    blendFactorDefault,
    blendFactorZero,
    blendFactorOne,
    blendFactorSrcColor,
    blendFactorOneMinusSrcColor,
    blendFactorSrcAlpha,
    blendFactorOneMinusSrcAlpha,
    blendFactorDstColor,
    blendFactorOneMinusDstColor,
    blendFactorDstAlpha,
    blendFactorOneMinusDstAlpha,
    blendFactorSrcAlphaSaturated,
    blendFactorBlendColor,
    blendFactorOneMinusBlendColor,
    blendFactorBlendAlpha,
    blendFactorOneMinusBlendAlpha,

type
  BlendOp* {.size:sizeof(int32).} = enum
    blendOpDefault,
    blendOpAdd,
    blendOpSubtract,
    blendOpReverseSubtract,

type
  ColorMask* {.size:sizeof(int32).} = enum
    colorMaskDefault = 0,
    colorMaskR = 1,
    colorMaskG = 2,
    colorMaskRg = 3,
    colorMaskB = 4,
    colorMaskRb = 5,
    colorMaskGb = 6,
    colorMaskRgb = 7,
    colorMaskA = 8,
    colorMaskRa = 9,
    colorMaskGa = 10,
    colorMaskRga = 11,
    colorMaskBa = 12,
    colorMaskRba = 13,
    colorMaskGba = 14,
    colorMaskRgba = 15,
    colorMaskNone = 16,

type
  LoadAction* {.size:sizeof(int32).} = enum
    loadActionDefault,
    loadActionClear,
    loadActionLoad,
    loadActionDontcare,

type
  StoreAction* {.size:sizeof(int32).} = enum
    storeActionDefault,
    storeActionStore,
    storeActionDontcare,

type ColorAttachmentAction* = object
  loadAction*:LoadAction
  storeAction*:StoreAction
  clearValue*:Color

type DepthAttachmentAction* = object
  loadAction*:LoadAction
  storeAction*:StoreAction
  clearValue*:float32

type StencilAttachmentAction* = object
  loadAction*:LoadAction
  storeAction*:StoreAction
  clearValue*:uint8

type PassAction* = object
  startCanary:uint32
  colors*:array[4, ColorAttachmentAction]
  depth*:DepthAttachmentAction
  stencil*:StencilAttachmentAction
  endCanary:uint32

converter toPassActioncolors*[N:static[int]](items: array[N, ColorAttachmentAction]): array[4, ColorAttachmentAction] =
  static: assert(N < 4)
  for index,item in items.pairs: result[index]=item

type Bindings* = object
  startCanary:uint32
  vertexBuffers*:array[8, Buffer]
  vertexBufferOffsets*:array[8, int32]
  indexBuffer*:Buffer
  indexBufferOffset*:int32
  vsImages*:array[12, Image]
  fsImages*:array[12, Image]
  endCanary:uint32

converter toBindingsvertexBuffers*[N:static[int]](items: array[N, Buffer]): array[8, Buffer] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

converter toBindingsvertexBufferOffsets*[N:static[int]](items: array[N, int32]): array[8, int32] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

converter toBindingsvsImages*[N:static[int]](items: array[N, Image]): array[12, Image] =
  static: assert(N < 12)
  for index,item in items.pairs: result[index]=item

converter toBindingsfsImages*[N:static[int]](items: array[N, Image]): array[12, Image] =
  static: assert(N < 12)
  for index,item in items.pairs: result[index]=item

type BufferDesc* = object
  startCanary:uint32
  size*:int
  `type`*:BufferType
  usage*:Usage
  data*:Range
  label*:cstring
  glBuffers*:array[2, uint32]
  mtlBuffers*:array[2, pointer]
  d3d11Buffer*:pointer
  wgpuBuffer*:pointer
  endCanary:uint32

converter toBufferDescglBuffers*[N:static[int]](items: array[N, uint32]): array[2, uint32] =
  static: assert(N < 2)
  for index,item in items.pairs: result[index]=item

converter toBufferDescmtlBuffers*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N < 2)
  for index,item in items.pairs: result[index]=item

type ImageData* = object
  subimage*:array[6, array[16, Range]]

converter toImageDatasubimage*[Y:static[int], X:static[int]](items: array[Y, array[X, Range]]): array[6, array[16, Range]] =
  static: assert(X < 16)
  static: assert(Y < 6)
  for indexY,itemY in items.pairs:
    for indexX, itemX in itemY.pairs:
      result[indexY][indexX] = itemX

type ImageDesc* = object
  startCanary:uint32
  `type`*:ImageType
  renderTarget*:bool
  width*:int32
  height*:int32
  numSlices*:int32
  numMipmaps*:int32
  usage*:Usage
  pixelFormat*:PixelFormat
  sampleCount*:int32
  minFilter*:Filter
  magFilter*:Filter
  wrapU*:Wrap
  wrapV*:Wrap
  wrapW*:Wrap
  borderColor*:BorderColor
  maxAnisotropy*:uint32
  minLod*:float32
  maxLod*:float32
  data*:ImageData
  label*:cstring
  glTextures*:array[2, uint32]
  glTextureTarget*:uint32
  mtlTextures*:array[2, pointer]
  d3d11Texture*:pointer
  d3d11ShaderResourceView*:pointer
  wgpuTexture*:pointer
  endCanary:uint32

converter toImageDescglTextures*[N:static[int]](items: array[N, uint32]): array[2, uint32] =
  static: assert(N < 2)
  for index,item in items.pairs: result[index]=item

converter toImageDescmtlTextures*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N < 2)
  for index,item in items.pairs: result[index]=item

type ShaderAttrDesc* = object
  name*:cstring
  semName*:cstring
  semIndex*:int32

type ShaderUniformDesc* = object
  name*:cstring
  `type`*:UniformType
  arrayCount*:int32

type ShaderUniformBlockDesc* = object
  size*:int
  layout*:UniformLayout
  uniforms*:array[16, ShaderUniformDesc]

converter toShaderUniformBlockDescuniforms*[N:static[int]](items: array[N, ShaderUniformDesc]): array[16, ShaderUniformDesc] =
  static: assert(N < 16)
  for index,item in items.pairs: result[index]=item

type ShaderImageDesc* = object
  name*:cstring
  imageType*:ImageType
  samplerType*:SamplerType

type ShaderStageDesc* = object
  source*:cstring
  bytecode*:Range
  entry*:cstring
  d3d11Target*:cstring
  uniformBlocks*:array[4, ShaderUniformBlockDesc]
  images*:array[12, ShaderImageDesc]

converter toShaderStageDescuniformBlocks*[N:static[int]](items: array[N, ShaderUniformBlockDesc]): array[4, ShaderUniformBlockDesc] =
  static: assert(N < 4)
  for index,item in items.pairs: result[index]=item

converter toShaderStageDescimages*[N:static[int]](items: array[N, ShaderImageDesc]): array[12, ShaderImageDesc] =
  static: assert(N < 12)
  for index,item in items.pairs: result[index]=item

type ShaderDesc* = object
  startCanary:uint32
  attrs*:array[16, ShaderAttrDesc]
  vs*:ShaderStageDesc
  fs*:ShaderStageDesc
  label*:cstring
  endCanary:uint32

converter toShaderDescattrs*[N:static[int]](items: array[N, ShaderAttrDesc]): array[16, ShaderAttrDesc] =
  static: assert(N < 16)
  for index,item in items.pairs: result[index]=item

type BufferLayoutDesc* = object
  stride*:int32
  stepFunc*:VertexStep
  stepRate*:int32

type VertexAttrDesc* = object
  bufferIndex*:int32
  offset*:int32
  format*:VertexFormat

type LayoutDesc* = object
  buffers*:array[8, BufferLayoutDesc]
  attrs*:array[16, VertexAttrDesc]

converter toLayoutDescbuffers*[N:static[int]](items: array[N, BufferLayoutDesc]): array[8, BufferLayoutDesc] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

converter toLayoutDescattrs*[N:static[int]](items: array[N, VertexAttrDesc]): array[16, VertexAttrDesc] =
  static: assert(N < 16)
  for index,item in items.pairs: result[index]=item

type StencilFaceState* = object
  compare*:CompareFunc
  failOp*:StencilOp
  depthFailOp*:StencilOp
  passOp*:StencilOp

type StencilState* = object
  enabled*:bool
  front*:StencilFaceState
  back*:StencilFaceState
  readMask*:uint8
  writeMask*:uint8
  `ref`*:uint8

type DepthState* = object
  pixelFormat*:PixelFormat
  compare*:CompareFunc
  writeEnabled*:bool
  bias*:float32
  biasSlopeScale*:float32
  biasClamp*:float32

type BlendState* = object
  enabled*:bool
  srcFactorRgb*:BlendFactor
  dstFactorRgb*:BlendFactor
  opRgb*:BlendOp
  srcFactorAlpha*:BlendFactor
  dstFactorAlpha*:BlendFactor
  opAlpha*:BlendOp

type ColorState* = object
  pixelFormat*:PixelFormat
  writeMask*:ColorMask
  blend*:BlendState

type PipelineDesc* = object
  startCanary:uint32
  shader*:Shader
  layout*:LayoutDesc
  depth*:DepthState
  stencil*:StencilState
  colorCount*:int32
  colors*:array[4, ColorState]
  primitiveType*:PrimitiveType
  indexType*:IndexType
  cullMode*:CullMode
  faceWinding*:FaceWinding
  sampleCount*:int32
  blendColor*:Color
  alphaToCoverageEnabled*:bool
  label*:cstring
  endCanary:uint32

converter toPipelineDesccolors*[N:static[int]](items: array[N, ColorState]): array[4, ColorState] =
  static: assert(N < 4)
  for index,item in items.pairs: result[index]=item

type PassAttachmentDesc* = object
  image*:Image
  mipLevel*:int32
  slice*:int32

type PassDesc* = object
  startCanary:uint32
  colorAttachments*:array[4, PassAttachmentDesc]
  resolveAttachments*:array[4, PassAttachmentDesc]
  depthStencilAttachment*:PassAttachmentDesc
  label*:cstring
  endCanary:uint32

converter toPassDesccolorAttachments*[N:static[int]](items: array[N, PassAttachmentDesc]): array[4, PassAttachmentDesc] =
  static: assert(N < 4)
  for index,item in items.pairs: result[index]=item

converter toPassDescresolveAttachments*[N:static[int]](items: array[N, PassAttachmentDesc]): array[4, PassAttachmentDesc] =
  static: assert(N < 4)
  for index,item in items.pairs: result[index]=item

type TraceHooks* = object
  userData*:pointer
  resetStateCache*:proc(a1:pointer) {.cdecl.}
  makeBuffer*:proc(a1:ptr BufferDesc, a2:Buffer, a3:pointer) {.cdecl.}
  makeImage*:proc(a1:ptr ImageDesc, a2:Image, a3:pointer) {.cdecl.}
  makeShader*:proc(a1:ptr ShaderDesc, a2:Shader, a3:pointer) {.cdecl.}
  makePipeline*:proc(a1:ptr PipelineDesc, a2:Pipeline, a3:pointer) {.cdecl.}
  makePass*:proc(a1:ptr PassDesc, a2:Pass, a3:pointer) {.cdecl.}
  destroyBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  destroyImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  destroyShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  destroyPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  destroyPass*:proc(a1:Pass, a2:pointer) {.cdecl.}
  updateBuffer*:proc(a1:Buffer, a2:ptr Range, a3:pointer) {.cdecl.}
  updateImage*:proc(a1:Image, a2:ptr ImageData, a3:pointer) {.cdecl.}
  appendBuffer*:proc(a1:Buffer, a2:ptr Range, a3:int32, a4:pointer) {.cdecl.}
  beginDefaultPass*:proc(a1:ptr PassAction, a2:int32, a3:int32, a4:pointer) {.cdecl.}
  beginPass*:proc(a1:Pass, a2:ptr PassAction, a3:pointer) {.cdecl.}
  applyViewport*:proc(a1:int32, a2:int32, a3:int32, a4:int32, a5:bool, a6:pointer) {.cdecl.}
  applyScissorRect*:proc(a1:int32, a2:int32, a3:int32, a4:int32, a5:bool, a6:pointer) {.cdecl.}
  applyPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  applyBindings*:proc(a1:ptr Bindings, a2:pointer) {.cdecl.}
  applyUniforms*:proc(a1:ShaderStage, a2:int32, a3:ptr Range, a4:pointer) {.cdecl.}
  draw*:proc(a1:int32, a2:int32, a3:int32, a4:pointer) {.cdecl.}
  endPass*:proc(a1:pointer) {.cdecl.}
  commit*:proc(a1:pointer) {.cdecl.}
  allocBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  allocImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  allocShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  allocPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  allocPass*:proc(a1:Pass, a2:pointer) {.cdecl.}
  deallocBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  deallocImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  deallocShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  deallocPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  deallocPass*:proc(a1:Pass, a2:pointer) {.cdecl.}
  initBuffer*:proc(a1:Buffer, a2:ptr BufferDesc, a3:pointer) {.cdecl.}
  initImage*:proc(a1:Image, a2:ptr ImageDesc, a3:pointer) {.cdecl.}
  initShader*:proc(a1:Shader, a2:ptr ShaderDesc, a3:pointer) {.cdecl.}
  initPipeline*:proc(a1:Pipeline, a2:ptr PipelineDesc, a3:pointer) {.cdecl.}
  initPass*:proc(a1:Pass, a2:ptr PassDesc, a3:pointer) {.cdecl.}
  uninitBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  uninitImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  uninitShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  uninitPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  uninitPass*:proc(a1:Pass, a2:pointer) {.cdecl.}
  failBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  failImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  failShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  failPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  failPass*:proc(a1:Pass, a2:pointer) {.cdecl.}
  pushDebugGroup*:proc(a1:cstring, a2:pointer) {.cdecl.}
  popDebugGroup*:proc(a1:pointer) {.cdecl.}
  errBufferPoolExhausted*:proc(a1:pointer) {.cdecl.}
  errImagePoolExhausted*:proc(a1:pointer) {.cdecl.}
  errShaderPoolExhausted*:proc(a1:pointer) {.cdecl.}
  errPipelinePoolExhausted*:proc(a1:pointer) {.cdecl.}
  errPassPoolExhausted*:proc(a1:pointer) {.cdecl.}
  errContextMismatch*:proc(a1:pointer) {.cdecl.}
  errPassInvalid*:proc(a1:pointer) {.cdecl.}
  errDrawInvalid*:proc(a1:pointer) {.cdecl.}
  errBindingsInvalid*:proc(a1:pointer) {.cdecl.}

type SlotInfo* = object
  state*:ResourceState
  resId*:uint32
  ctxId*:uint32

type BufferInfo* = object
  slot*:SlotInfo
  updateFrameIndex*:uint32
  appendFrameIndex*:uint32
  appendPos*:int32
  appendOverflow*:bool
  numSlots*:int32
  activeSlot*:int32

type ImageInfo* = object
  slot*:SlotInfo
  updFrameIndex*:uint32
  numSlots*:int32
  activeSlot*:int32

type ShaderInfo* = object
  slot*:SlotInfo

type PipelineInfo* = object
  slot*:SlotInfo

type PassInfo* = object
  slot*:SlotInfo

type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemGlTextureFormatNotSupported,
    logitemGl3dTexturesNotSupported,
    logitemGlArrayTexturesNotSupported,
    logitemGlShaderCompilationFailed,
    logitemGlShaderLinkingFailed,
    logitemGlVertexAttributeNotFoundInShader,
    logitemGlTextureNameNotFoundInShader,
    logitemGlFramebufferIncomplete,
    logitemGlMsaaFramebufferIncomplete,
    logitemD3d11CreateBufferFailed,
    logitemD3d11CreateDepthTextureUnsupportedPixelFormat,
    logitemD3d11CreateDepthTextureFailed,
    logitemD3d11Create2dTextureUnsupportedPixelFormat,
    logitemD3d11Create2dTextureFailed,
    logitemD3d11Create2dSrvFailed,
    logitemD3d11Create3dTextureUnsupportedPixelFormat,
    logitemD3d11Create3dTextureFailed,
    logitemD3d11Create3dSrvFailed,
    logitemD3d11CreateMsaaTextureFailed,
    logitemD3d11CreateSamplerStateFailed,
    logitemD3d11LoadD3dcompiler47DllFailed,
    logitemD3d11ShaderCompilationFailed,
    logitemD3d11ShaderCompilationOutput,
    logitemD3d11CreateConstantBufferFailed,
    logitemD3d11CreateInputLayoutFailed,
    logitemD3d11CreateRasterizerStateFailed,
    logitemD3d11CreateDepthStencilStateFailed,
    logitemD3d11CreateBlendStateFailed,
    logitemD3d11CreateRtvFailed,
    logitemD3d11CreateDsvFailed,
    logitemD3d11MapForUpdateBufferFailed,
    logitemD3d11MapForAppendBufferFailed,
    logitemD3d11MapForUpdateImageFailed,
    logitemMetalTextureFormatNotSupported,
    logitemMetalShaderCompilationFailed,
    logitemMetalShaderCreationFailed,
    logitemMetalShaderCompilationOutput,
    logitemMetalVertexShaderEntryNotFound,
    logitemMetalFragmentShaderEntryNotFound,
    logitemMetalCreateRpsFailed,
    logitemMetalCreateRpsOutput,
    logitemWgpuMapUniformBufferFailed,
    logitemWgpuStagingBufferFullCopyToBuffer,
    logitemWgpuStagingBufferFullCopyToTexture,
    logitemWgpuResetStateCacheFixme,
    logitemWgpuActivateContextFixme,
    logitemUninitBufferActiveContextMismatch,
    logitemUninitImageActiveContextMismatch,
    logitemUninitShaderActiveContextMismatch,
    logitemUninitPipelineActiveContextMismatch,
    logitemUninitPassActiveContextMismatch,
    logitemIdenticalCommitListener,
    logitemCommitListenerArrayFull,
    logitemTraceHooksNotEnabled,
    logitemDeallocBufferInvalidState,
    logitemDeallocImageInvalidState,
    logitemDeallocShaderInvalidState,
    logitemDeallocPipelineInvalidState,
    logitemDeallocPassInvalidState,
    logitemInitBufferInvalidState,
    logitemInitImageInvalidState,
    logitemInitShaderInvalidState,
    logitemInitPipelineInvalidState,
    logitemInitPassInvalidState,
    logitemUninitBufferInvalidState,
    logitemUninitImageInvalidState,
    logitemUninitShaderInvalidState,
    logitemUninitPipelineInvalidState,
    logitemUninitPassInvalidState,
    logitemFailBufferInvalidState,
    logitemFailImageInvalidState,
    logitemFailShaderInvalidState,
    logitemFailPipelineInvalidState,
    logitemFailPassInvalidState,
    logitemBufferPoolExhausted,
    logitemImagePoolExhausted,
    logitemShaderPoolExhausted,
    logitemPipelinePoolExhausted,
    logitemPassPoolExhausted,
    logitemDrawWithoutBindings,
    logitemValidateBufferdescCanary,
    logitemValidateBufferdescSize,
    logitemValidateBufferdescData,
    logitemValidateBufferdescDataSize,
    logitemValidateBufferdescNoData,
    logitemValidateImagedataNodata,
    logitemValidateImagedataDataSize,
    logitemValidateImagedescCanary,
    logitemValidateImagedescWidth,
    logitemValidateImagedescHeight,
    logitemValidateImagedescRtPixelformat,
    logitemValidateImagedescNonrtPixelformat,
    logitemValidateImagedescMsaaButNoRt,
    logitemValidateImagedescNoMsaaRtSupport,
    logitemValidateImagedescMsaaNumMipmaps,
    logitemValidateImagedescMsaa3dImage,
    logitemValidateImagedescDepth3dImage,
    logitemValidateImagedescRtImmutable,
    logitemValidateImagedescRtNoData,
    logitemValidateImagedescInjectedNoData,
    logitemValidateImagedescDynamicNoData,
    logitemValidateImagedescCompressedImmutable,
    logitemValidateShaderdescCanary,
    logitemValidateShaderdescSource,
    logitemValidateShaderdescBytecode,
    logitemValidateShaderdescSourceOrBytecode,
    logitemValidateShaderdescNoBytecodeSize,
    logitemValidateShaderdescNoContUbs,
    logitemValidateShaderdescNoContUbMembers,
    logitemValidateShaderdescNoUbMembers,
    logitemValidateShaderdescUbMemberName,
    logitemValidateShaderdescUbSizeMismatch,
    logitemValidateShaderdescUbArrayCount,
    logitemValidateShaderdescUbStd140ArrayType,
    logitemValidateShaderdescNoContImgs,
    logitemValidateShaderdescImgName,
    logitemValidateShaderdescAttrSemantics,
    logitemValidateShaderdescAttrStringTooLong,
    logitemValidatePipelinedescCanary,
    logitemValidatePipelinedescShader,
    logitemValidatePipelinedescNoAttrs,
    logitemValidatePipelinedescLayoutStride4,
    logitemValidatePipelinedescAttrSemantics,
    logitemValidatePassdescCanary,
    logitemValidatePassdescNoColorAtts,
    logitemValidatePassdescNoContColorAtts,
    logitemValidatePassdescImage,
    logitemValidatePassdescMiplevel,
    logitemValidatePassdescFace,
    logitemValidatePassdescLayer,
    logitemValidatePassdescSlice,
    logitemValidatePassdescImageNoRt,
    logitemValidatePassdescColorInvPixelformat,
    logitemValidatePassdescDepthInvPixelformat,
    logitemValidatePassdescImageSizes,
    logitemValidatePassdescImageSampleCounts,
    logitemValidatePassdescResolveColorImageMsaa,
    logitemValidatePassdescResolveImage,
    logitemValidatePassdescResolveSampleCount,
    logitemValidatePassdescResolveMiplevel,
    logitemValidatePassdescResolveFace,
    logitemValidatePassdescResolveLayer,
    logitemValidatePassdescResolveSlice,
    logitemValidatePassdescResolveImageNoRt,
    logitemValidatePassdescResolveImageSizes,
    logitemValidatePassdescResolveImageFormat,
    logitemValidatePassdescDepthImage,
    logitemValidatePassdescDepthMiplevel,
    logitemValidatePassdescDepthFace,
    logitemValidatePassdescDepthLayer,
    logitemValidatePassdescDepthSlice,
    logitemValidatePassdescDepthImageNoRt,
    logitemValidatePassdescDepthImageSizes,
    logitemValidatePassdescDepthImageSampleCount,
    logitemValidateBeginpassPass,
    logitemValidateBeginpassColorAttachmentImage,
    logitemValidateBeginpassResolveAttachmentImage,
    logitemValidateBeginpassDepthstencilAttachmentImage,
    logitemValidateApipPipelineValidId,
    logitemValidateApipPipelineExists,
    logitemValidateApipPipelineValid,
    logitemValidateApipShaderExists,
    logitemValidateApipShaderValid,
    logitemValidateApipAttCount,
    logitemValidateApipColorFormat,
    logitemValidateApipDepthFormat,
    logitemValidateApipSampleCount,
    logitemValidateAbndPipeline,
    logitemValidateAbndPipelineExists,
    logitemValidateAbndPipelineValid,
    logitemValidateAbndVbs,
    logitemValidateAbndVbExists,
    logitemValidateAbndVbType,
    logitemValidateAbndVbOverflow,
    logitemValidateAbndNoIb,
    logitemValidateAbndIb,
    logitemValidateAbndIbExists,
    logitemValidateAbndIbType,
    logitemValidateAbndIbOverflow,
    logitemValidateAbndVsImgs,
    logitemValidateAbndVsImgExists,
    logitemValidateAbndVsImgTypes,
    logitemValidateAbndVsImgMsaa,
    logitemValidateAbndVsImgDepth,
    logitemValidateAbndFsImgs,
    logitemValidateAbndFsImgExists,
    logitemValidateAbndFsImgTypes,
    logitemValidateAbndFsImgMsaa,
    logitemValidateAbndFsImgDepth,
    logitemValidateAubNoPipeline,
    logitemValidateAubNoUbAtSlot,
    logitemValidateAubSize,
    logitemValidateUpdatebufUsage,
    logitemValidateUpdatebufSize,
    logitemValidateUpdatebufOnce,
    logitemValidateUpdatebufAppend,
    logitemValidateAppendbufUsage,
    logitemValidateAppendbufSize,
    logitemValidateAppendbufUpdate,
    logitemValidateUpdimgUsage,
    logitemValidateUpdimgOnce,
    logitemValidationFailed,

type MetalContextDesc* = object
  device*:pointer
  renderpassDescriptorCb*:proc():pointer {.cdecl.}
  renderpassDescriptorUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  drawableCb*:proc():pointer {.cdecl.}
  drawableUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  userData*:pointer

type D3d11ContextDesc* = object
  device*:pointer
  deviceContext*:pointer
  renderTargetViewCb*:proc():pointer {.cdecl.}
  renderTargetViewUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  depthStencilViewCb*:proc():pointer {.cdecl.}
  depthStencilViewUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  userData*:pointer

type WgpuContextDesc* = object
  device*:pointer
  renderViewCb*:proc():pointer {.cdecl.}
  renderViewUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  resolveViewCb*:proc():pointer {.cdecl.}
  resolveViewUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  depthStencilViewCb*:proc():pointer {.cdecl.}
  depthStencilViewUserdataCb*:proc(a1:pointer):pointer {.cdecl.}
  userData*:pointer

type ContextDesc* = object
  colorFormat*:int32
  depthFormat*:int32
  sampleCount*:int32
  metal*:MetalContextDesc
  d3d11*:D3d11ContextDesc
  wgpu*:WgpuContextDesc

type CommitListener* = object
  fn*:proc(a1:pointer) {.cdecl.}
  userData*:pointer

type Allocator* = object
  alloc*:proc(a1:int, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Logger* = object
  fn*:proc(a1:cstring, a2:uint32, a3:uint32, a4:cstring, a5:uint32, a6:cstring, a7:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  startCanary:uint32
  bufferPoolSize*:int32
  imagePoolSize*:int32
  shaderPoolSize*:int32
  pipelinePoolSize*:int32
  passPoolSize*:int32
  contextPoolSize*:int32
  uniformBufferSize*:int32
  stagingBufferSize*:int32
  samplerCacheSize*:int32
  maxCommitListeners*:int32
  disableValidation*:bool
  allocator*:Allocator
  logger*:Logger
  context*:ContextDesc
  endCanary:uint32

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sg_setup".}
proc setup*(desc:Desc):void =
    c_setup(unsafeAddr(desc))

proc c_shutdown():void {.cdecl, importc:"sg_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_isvalid():bool {.cdecl, importc:"sg_isvalid".}
proc isvalid*():bool =
    c_isvalid()

proc c_resetStateCache():void {.cdecl, importc:"sg_reset_state_cache".}
proc resetStateCache*():void =
    c_resetStateCache()

proc c_installTraceHooks(traceHooks:ptr TraceHooks):TraceHooks {.cdecl, importc:"sg_install_trace_hooks".}
proc installTraceHooks*(traceHooks:TraceHooks):TraceHooks =
    c_installTraceHooks(unsafeAddr(trace_hooks))

proc c_pushDebugGroup(name:cstring):void {.cdecl, importc:"sg_push_debug_group".}
proc pushDebugGroup*(name:cstring):void =
    c_pushDebugGroup(name)

proc c_popDebugGroup():void {.cdecl, importc:"sg_pop_debug_group".}
proc popDebugGroup*():void =
    c_popDebugGroup()

proc c_addCommitListener(listener:CommitListener):bool {.cdecl, importc:"sg_add_commit_listener".}
proc addCommitListener*(listener:CommitListener):bool =
    c_addCommitListener(listener)

proc c_removeCommitListener(listener:CommitListener):bool {.cdecl, importc:"sg_remove_commit_listener".}
proc removeCommitListener*(listener:CommitListener):bool =
    c_removeCommitListener(listener)

proc c_makeBuffer(desc:ptr BufferDesc):Buffer {.cdecl, importc:"sg_make_buffer".}
proc makeBuffer*(desc:BufferDesc):Buffer =
    c_makeBuffer(unsafeAddr(desc))

proc c_makeImage(desc:ptr ImageDesc):Image {.cdecl, importc:"sg_make_image".}
proc makeImage*(desc:ImageDesc):Image =
    c_makeImage(unsafeAddr(desc))

proc c_makeShader(desc:ptr ShaderDesc):Shader {.cdecl, importc:"sg_make_shader".}
proc makeShader*(desc:ShaderDesc):Shader =
    c_makeShader(unsafeAddr(desc))

proc c_makePipeline(desc:ptr PipelineDesc):Pipeline {.cdecl, importc:"sg_make_pipeline".}
proc makePipeline*(desc:PipelineDesc):Pipeline =
    c_makePipeline(unsafeAddr(desc))

proc c_makePass(desc:ptr PassDesc):Pass {.cdecl, importc:"sg_make_pass".}
proc makePass*(desc:PassDesc):Pass =
    c_makePass(unsafeAddr(desc))

proc c_destroyBuffer(buf:Buffer):void {.cdecl, importc:"sg_destroy_buffer".}
proc destroyBuffer*(buf:Buffer):void =
    c_destroyBuffer(buf)

proc c_destroyImage(img:Image):void {.cdecl, importc:"sg_destroy_image".}
proc destroyImage*(img:Image):void =
    c_destroyImage(img)

proc c_destroyShader(shd:Shader):void {.cdecl, importc:"sg_destroy_shader".}
proc destroyShader*(shd:Shader):void =
    c_destroyShader(shd)

proc c_destroyPipeline(pip:Pipeline):void {.cdecl, importc:"sg_destroy_pipeline".}
proc destroyPipeline*(pip:Pipeline):void =
    c_destroyPipeline(pip)

proc c_destroyPass(pass:Pass):void {.cdecl, importc:"sg_destroy_pass".}
proc destroyPass*(pass:Pass):void =
    c_destroyPass(pass)

proc c_updateBuffer(buf:Buffer, data:ptr Range):void {.cdecl, importc:"sg_update_buffer".}
proc updateBuffer*(buf:Buffer, data:Range):void =
    c_updateBuffer(buf, unsafeAddr(data))

proc c_updateImage(img:Image, data:ptr ImageData):void {.cdecl, importc:"sg_update_image".}
proc updateImage*(img:Image, data:ImageData):void =
    c_updateImage(img, unsafeAddr(data))

proc c_appendBuffer(buf:Buffer, data:ptr Range):int32 {.cdecl, importc:"sg_append_buffer".}
proc appendBuffer*(buf:Buffer, data:Range):int32 =
    c_appendBuffer(buf, unsafeAddr(data))

proc c_queryBufferOverflow(buf:Buffer):bool {.cdecl, importc:"sg_query_buffer_overflow".}
proc queryBufferOverflow*(buf:Buffer):bool =
    c_queryBufferOverflow(buf)

proc c_queryBufferWillOverflow(buf:Buffer, size:int):bool {.cdecl, importc:"sg_query_buffer_will_overflow".}
proc queryBufferWillOverflow*(buf:Buffer, size:int):bool =
    c_queryBufferWillOverflow(buf, size)

proc c_beginDefaultPass(passAction:ptr PassAction, width:int32, height:int32):void {.cdecl, importc:"sg_begin_default_pass".}
proc beginDefaultPass*(passAction:PassAction, width:int32, height:int32):void =
    c_beginDefaultPass(unsafeAddr(pass_action), width, height)

proc c_beginDefaultPassf(passAction:ptr PassAction, width:float32, height:float32):void {.cdecl, importc:"sg_begin_default_passf".}
proc beginDefaultPassf*(passAction:PassAction, width:float32, height:float32):void =
    c_beginDefaultPassf(unsafeAddr(pass_action), width, height)

proc c_beginPass(pass:Pass, passAction:ptr PassAction):void {.cdecl, importc:"sg_begin_pass".}
proc beginPass*(pass:Pass, passAction:PassAction):void =
    c_beginPass(pass, unsafeAddr(pass_action))

proc c_applyViewport(x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void {.cdecl, importc:"sg_apply_viewport".}
proc applyViewport*(x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void =
    c_applyViewport(x, y, width, height, origin_top_left)

proc c_applyViewportf(x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void {.cdecl, importc:"sg_apply_viewportf".}
proc applyViewportf*(x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void =
    c_applyViewportf(x, y, width, height, origin_top_left)

proc c_applyScissorRect(x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void {.cdecl, importc:"sg_apply_scissor_rect".}
proc applyScissorRect*(x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void =
    c_applyScissorRect(x, y, width, height, origin_top_left)

proc c_applyScissorRectf(x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void {.cdecl, importc:"sg_apply_scissor_rectf".}
proc applyScissorRectf*(x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void =
    c_applyScissorRectf(x, y, width, height, origin_top_left)

proc c_applyPipeline(pip:Pipeline):void {.cdecl, importc:"sg_apply_pipeline".}
proc applyPipeline*(pip:Pipeline):void =
    c_applyPipeline(pip)

proc c_applyBindings(bindings:ptr Bindings):void {.cdecl, importc:"sg_apply_bindings".}
proc applyBindings*(bindings:Bindings):void =
    c_applyBindings(unsafeAddr(bindings))

proc c_applyUniforms(stage:ShaderStage, ubIndex:int32, data:ptr Range):void {.cdecl, importc:"sg_apply_uniforms".}
proc applyUniforms*(stage:ShaderStage, ubIndex:int32, data:Range):void =
    c_applyUniforms(stage, ub_index, unsafeAddr(data))

proc c_draw(baseElement:int32, numElements:int32, numInstances:int32):void {.cdecl, importc:"sg_draw".}
proc draw*(baseElement:int32, numElements:int32, numInstances:int32):void =
    c_draw(base_element, num_elements, num_instances)

proc c_endPass():void {.cdecl, importc:"sg_end_pass".}
proc endPass*():void =
    c_endPass()

proc c_commit():void {.cdecl, importc:"sg_commit".}
proc commit*():void =
    c_commit()

proc c_queryDesc():Desc {.cdecl, importc:"sg_query_desc".}
proc queryDesc*():Desc =
    c_queryDesc()

proc c_queryBackend():Backend {.cdecl, importc:"sg_query_backend".}
proc queryBackend*():Backend =
    c_queryBackend()

proc c_queryFeatures():Features {.cdecl, importc:"sg_query_features".}
proc queryFeatures*():Features =
    c_queryFeatures()

proc c_queryLimits():Limits {.cdecl, importc:"sg_query_limits".}
proc queryLimits*():Limits =
    c_queryLimits()

proc c_queryPixelformat(fmt:PixelFormat):PixelformatInfo {.cdecl, importc:"sg_query_pixelformat".}
proc queryPixelformat*(fmt:PixelFormat):PixelformatInfo =
    c_queryPixelformat(fmt)

proc c_queryBufferState(buf:Buffer):ResourceState {.cdecl, importc:"sg_query_buffer_state".}
proc queryBufferState*(buf:Buffer):ResourceState =
    c_queryBufferState(buf)

proc c_queryImageState(img:Image):ResourceState {.cdecl, importc:"sg_query_image_state".}
proc queryImageState*(img:Image):ResourceState =
    c_queryImageState(img)

proc c_queryShaderState(shd:Shader):ResourceState {.cdecl, importc:"sg_query_shader_state".}
proc queryShaderState*(shd:Shader):ResourceState =
    c_queryShaderState(shd)

proc c_queryPipelineState(pip:Pipeline):ResourceState {.cdecl, importc:"sg_query_pipeline_state".}
proc queryPipelineState*(pip:Pipeline):ResourceState =
    c_queryPipelineState(pip)

proc c_queryPassState(pass:Pass):ResourceState {.cdecl, importc:"sg_query_pass_state".}
proc queryPassState*(pass:Pass):ResourceState =
    c_queryPassState(pass)

proc c_queryBufferInfo(buf:Buffer):BufferInfo {.cdecl, importc:"sg_query_buffer_info".}
proc queryBufferInfo*(buf:Buffer):BufferInfo =
    c_queryBufferInfo(buf)

proc c_queryImageInfo(img:Image):ImageInfo {.cdecl, importc:"sg_query_image_info".}
proc queryImageInfo*(img:Image):ImageInfo =
    c_queryImageInfo(img)

proc c_queryShaderInfo(shd:Shader):ShaderInfo {.cdecl, importc:"sg_query_shader_info".}
proc queryShaderInfo*(shd:Shader):ShaderInfo =
    c_queryShaderInfo(shd)

proc c_queryPipelineInfo(pip:Pipeline):PipelineInfo {.cdecl, importc:"sg_query_pipeline_info".}
proc queryPipelineInfo*(pip:Pipeline):PipelineInfo =
    c_queryPipelineInfo(pip)

proc c_queryPassInfo(pass:Pass):PassInfo {.cdecl, importc:"sg_query_pass_info".}
proc queryPassInfo*(pass:Pass):PassInfo =
    c_queryPassInfo(pass)

proc c_queryBufferDesc(buf:Buffer):BufferDesc {.cdecl, importc:"sg_query_buffer_desc".}
proc queryBufferDesc*(buf:Buffer):BufferDesc =
    c_queryBufferDesc(buf)

proc c_queryImageDesc(img:Image):ImageDesc {.cdecl, importc:"sg_query_image_desc".}
proc queryImageDesc*(img:Image):ImageDesc =
    c_queryImageDesc(img)

proc c_queryShaderDesc(shd:Shader):ShaderDesc {.cdecl, importc:"sg_query_shader_desc".}
proc queryShaderDesc*(shd:Shader):ShaderDesc =
    c_queryShaderDesc(shd)

proc c_queryPipelineDesc(pip:Pipeline):PipelineDesc {.cdecl, importc:"sg_query_pipeline_desc".}
proc queryPipelineDesc*(pip:Pipeline):PipelineDesc =
    c_queryPipelineDesc(pip)

proc c_queryPassDesc(pass:Pass):PassDesc {.cdecl, importc:"sg_query_pass_desc".}
proc queryPassDesc*(pass:Pass):PassDesc =
    c_queryPassDesc(pass)

proc c_queryBufferDefaults(desc:ptr BufferDesc):BufferDesc {.cdecl, importc:"sg_query_buffer_defaults".}
proc queryBufferDefaults*(desc:BufferDesc):BufferDesc =
    c_queryBufferDefaults(unsafeAddr(desc))

proc c_queryImageDefaults(desc:ptr ImageDesc):ImageDesc {.cdecl, importc:"sg_query_image_defaults".}
proc queryImageDefaults*(desc:ImageDesc):ImageDesc =
    c_queryImageDefaults(unsafeAddr(desc))

proc c_queryShaderDefaults(desc:ptr ShaderDesc):ShaderDesc {.cdecl, importc:"sg_query_shader_defaults".}
proc queryShaderDefaults*(desc:ShaderDesc):ShaderDesc =
    c_queryShaderDefaults(unsafeAddr(desc))

proc c_queryPipelineDefaults(desc:ptr PipelineDesc):PipelineDesc {.cdecl, importc:"sg_query_pipeline_defaults".}
proc queryPipelineDefaults*(desc:PipelineDesc):PipelineDesc =
    c_queryPipelineDefaults(unsafeAddr(desc))

proc c_queryPassDefaults(desc:ptr PassDesc):PassDesc {.cdecl, importc:"sg_query_pass_defaults".}
proc queryPassDefaults*(desc:PassDesc):PassDesc =
    c_queryPassDefaults(unsafeAddr(desc))

proc c_allocBuffer():Buffer {.cdecl, importc:"sg_alloc_buffer".}
proc allocBuffer*():Buffer =
    c_allocBuffer()

proc c_allocImage():Image {.cdecl, importc:"sg_alloc_image".}
proc allocImage*():Image =
    c_allocImage()

proc c_allocShader():Shader {.cdecl, importc:"sg_alloc_shader".}
proc allocShader*():Shader =
    c_allocShader()

proc c_allocPipeline():Pipeline {.cdecl, importc:"sg_alloc_pipeline".}
proc allocPipeline*():Pipeline =
    c_allocPipeline()

proc c_allocPass():Pass {.cdecl, importc:"sg_alloc_pass".}
proc allocPass*():Pass =
    c_allocPass()

proc c_deallocBuffer(buf:Buffer):void {.cdecl, importc:"sg_dealloc_buffer".}
proc deallocBuffer*(buf:Buffer):void =
    c_deallocBuffer(buf)

proc c_deallocImage(img:Image):void {.cdecl, importc:"sg_dealloc_image".}
proc deallocImage*(img:Image):void =
    c_deallocImage(img)

proc c_deallocShader(shd:Shader):void {.cdecl, importc:"sg_dealloc_shader".}
proc deallocShader*(shd:Shader):void =
    c_deallocShader(shd)

proc c_deallocPipeline(pip:Pipeline):void {.cdecl, importc:"sg_dealloc_pipeline".}
proc deallocPipeline*(pip:Pipeline):void =
    c_deallocPipeline(pip)

proc c_deallocPass(pass:Pass):void {.cdecl, importc:"sg_dealloc_pass".}
proc deallocPass*(pass:Pass):void =
    c_deallocPass(pass)

proc c_initBuffer(buf:Buffer, desc:ptr BufferDesc):void {.cdecl, importc:"sg_init_buffer".}
proc initBuffer*(buf:Buffer, desc:BufferDesc):void =
    c_initBuffer(buf, unsafeAddr(desc))

proc c_initImage(img:Image, desc:ptr ImageDesc):void {.cdecl, importc:"sg_init_image".}
proc initImage*(img:Image, desc:ImageDesc):void =
    c_initImage(img, unsafeAddr(desc))

proc c_initShader(shd:Shader, desc:ptr ShaderDesc):void {.cdecl, importc:"sg_init_shader".}
proc initShader*(shd:Shader, desc:ShaderDesc):void =
    c_initShader(shd, unsafeAddr(desc))

proc c_initPipeline(pip:Pipeline, desc:ptr PipelineDesc):void {.cdecl, importc:"sg_init_pipeline".}
proc initPipeline*(pip:Pipeline, desc:PipelineDesc):void =
    c_initPipeline(pip, unsafeAddr(desc))

proc c_initPass(pass:Pass, desc:ptr PassDesc):void {.cdecl, importc:"sg_init_pass".}
proc initPass*(pass:Pass, desc:PassDesc):void =
    c_initPass(pass, unsafeAddr(desc))

proc c_uninitBuffer(buf:Buffer):void {.cdecl, importc:"sg_uninit_buffer".}
proc uninitBuffer*(buf:Buffer):void =
    c_uninitBuffer(buf)

proc c_uninitImage(img:Image):void {.cdecl, importc:"sg_uninit_image".}
proc uninitImage*(img:Image):void =
    c_uninitImage(img)

proc c_uninitShader(shd:Shader):void {.cdecl, importc:"sg_uninit_shader".}
proc uninitShader*(shd:Shader):void =
    c_uninitShader(shd)

proc c_uninitPipeline(pip:Pipeline):void {.cdecl, importc:"sg_uninit_pipeline".}
proc uninitPipeline*(pip:Pipeline):void =
    c_uninitPipeline(pip)

proc c_uninitPass(pass:Pass):void {.cdecl, importc:"sg_uninit_pass".}
proc uninitPass*(pass:Pass):void =
    c_uninitPass(pass)

proc c_failBuffer(buf:Buffer):void {.cdecl, importc:"sg_fail_buffer".}
proc failBuffer*(buf:Buffer):void =
    c_failBuffer(buf)

proc c_failImage(img:Image):void {.cdecl, importc:"sg_fail_image".}
proc failImage*(img:Image):void =
    c_failImage(img)

proc c_failShader(shd:Shader):void {.cdecl, importc:"sg_fail_shader".}
proc failShader*(shd:Shader):void =
    c_failShader(shd)

proc c_failPipeline(pip:Pipeline):void {.cdecl, importc:"sg_fail_pipeline".}
proc failPipeline*(pip:Pipeline):void =
    c_failPipeline(pip)

proc c_failPass(pass:Pass):void {.cdecl, importc:"sg_fail_pass".}
proc failPass*(pass:Pass):void =
    c_failPass(pass)

proc c_setupContext():Context {.cdecl, importc:"sg_setup_context".}
proc setupContext*():Context =
    c_setupContext()

proc c_activateContext(ctxId:Context):void {.cdecl, importc:"sg_activate_context".}
proc activateContext*(ctxId:Context):void =
    c_activateContext(ctx_id)

proc c_discardContext(ctxId:Context):void {.cdecl, importc:"sg_discard_context".}
proc discardContext*(ctxId:Context):void =
    c_discardContext(ctx_id)

proc c_d3d11Device():pointer {.cdecl, importc:"sg_d3d11_device".}
proc d3d11Device*():pointer =
    c_d3d11Device()

proc c_mtlDevice():pointer {.cdecl, importc:"sg_mtl_device".}
proc mtlDevice*():pointer =
    c_mtlDevice()

proc c_mtlRenderCommandEncoder():pointer {.cdecl, importc:"sg_mtl_render_command_encoder".}
proc mtlRenderCommandEncoder*():pointer =
    c_mtlRenderCommandEncoder()

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
elif defined linux:
  const gl*    = true
  const d3d11* = false
  const metal* = false
else:
  error("unsupported platform")

when defined windows:
  when not defined vcc:
    {.passl:"-lkernel32 -luser32 -lshell32 -lgdi32".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE33".}
  else:
    {.passc:"-DSOKOL_D3D11".}
    when not defined vcc:
      {.passl:"-ld3d11 -ldxgi".}
elif defined macosx:
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE33".}
    {.passl:"-framework OpenGL".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
elif defined linux:
  {.passc:"-DSOKOL_GLCORE33".}
  {.passl:"-lX11 -lXi -lXcursor -lGL -lm -ldl -lpthread".}
else:
  error("unsupported platform")

## Convert a 4-element tuple of numbers to a gfx.Color
converter toColor*[R:SomeNumber,G:SomeNumber,B:SomeNumber,A:SomeNumber](rgba: tuple [r:R,g:G,b:B,a:A]):Color =
  Color(r:rgba.r.float32, g:rgba.g.float32, b:rgba.b.float32, a:rgba.a.float32)

## Convert a 3-element tuple of numbers to a gfx.Color
converter toColor*[R:SomeNumber,G:SomeNumber,B:SomeNumber](rgba: tuple [r:R,g:G,b:B]):Color =
  Color(r:rgba.r.float32, g:rgba.g.float32, b:rgba.b.float32, a:1.float32)

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_gfx.c".}
