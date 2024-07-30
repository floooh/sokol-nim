## machine generated, do not edit


type Buffer* = object
  id*:uint32

type Image* = object
  id*:uint32

type Sampler* = object
  id*:uint32

type Shader* = object
  id*:uint32

type Pipeline* = object
  id*:uint32

type Attachments* = object
  id*:uint32

type Range* = object
  `addr`*:pointer
  size*:int

const
  invalidId* = 0
  numShaderStages* = 2
  numInflightFrames* = 2
  maxColorAttachments* = 4
  maxVertexBuffers* = 8
  maxShaderstageImages* = 12
  maxShaderstageSamplers* = 8
  maxShaderstageImagesamplerpairs* = 12
  maxShaderstageStoragebuffers* = 8
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
    backendGlcore,
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
    pixelFormatRgb9e5,
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
    pixelFormatBc3Srgba,
    pixelFormatBc4R,
    pixelFormatBc4Rsn,
    pixelFormatBc5Rg,
    pixelFormatBc5Rgsn,
    pixelFormatBc6hRgbf,
    pixelFormatBc6hRgbuf,
    pixelFormatBc7Rgba,
    pixelFormatBc7Srgba,
    pixelFormatPvrtcRgb2bpp,
    pixelFormatPvrtcRgb4bpp,
    pixelFormatPvrtcRgba2bpp,
    pixelFormatPvrtcRgba4bpp,
    pixelFormatEtc2Rgb8,
    pixelFormatEtc2Srgb8,
    pixelFormatEtc2Rgb8a1,
    pixelFormatEtc2Rgba8,
    pixelFormatEtc2Srgb8a8,
    pixelFormatEacR11,
    pixelFormatEacR11sn,
    pixelFormatEacRg11,
    pixelFormatEacRg11sn,
    pixelFormatAstc4x4Rgba,
    pixelFormatAstc4x4Srgba,

type PixelformatInfo* = object
  sample*:bool
  filter*:bool
  render*:bool
  blend*:bool
  msaa*:bool
  depth*:bool
  compressed*:bool
  bytesPerPixel*:int32

type Features* = object
  originTopLeft*:bool
  imageClampToBorder*:bool
  mrtIndependentBlendState*:bool
  mrtIndependentWriteMask*:bool
  storageBuffer*:bool

type Limits* = object
  maxImageSize2d*:int32
  maxImageSizeCube*:int32
  maxImageSize3d*:int32
  maxImageSizeArray*:int32
  maxImageArrayLayers*:int32
  maxVertexAttrs*:int32
  glMaxVertexUniformComponents*:int32
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
    bufferTypeStoragebuffer,

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
  ImageSampleType* {.size:sizeof(int32).} = enum
    imagesampletypeDefault,
    imagesampletypeFloat,
    imagesampletypeDepth,
    imagesampletypeSint,
    imagesampletypeUint,
    imagesampletypeUnfilterableFloat,

type
  SamplerType* {.size:sizeof(int32).} = enum
    samplerTypeDefault,
    samplerTypeFiltering,
    samplerTypeNonfiltering,
    samplerTypeComparison,

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
    filterNone,
    filterNearest,
    filterLinear,

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
  colors*:array[4, ColorAttachmentAction]
  depth*:DepthAttachmentAction
  stencil*:StencilAttachmentAction

converter toPassActioncolors*[N:static[int]](items: array[N, ColorAttachmentAction]): array[4, ColorAttachmentAction] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type MetalSwapchain* = object
  currentDrawable*:pointer
  depthStencilTexture*:pointer
  msaaColorTexture*:pointer

type D3d11Swapchain* = object
  renderView*:pointer
  resolveView*:pointer
  depthStencilView*:pointer

type WgpuSwapchain* = object
  renderView*:pointer
  resolveView*:pointer
  depthStencilView*:pointer

type GlSwapchain* = object
  framebuffer*:uint32

type Swapchain* = object
  width*:int32
  height*:int32
  sampleCount*:int32
  colorFormat*:PixelFormat
  depthFormat*:PixelFormat
  metal*:MetalSwapchain
  d3d11*:D3d11Swapchain
  wgpu*:WgpuSwapchain
  gl*:GlSwapchain

type Pass* = object
  startCanary:uint32
  action*:PassAction
  attachments*:Attachments
  swapchain*:Swapchain
  label*:cstring
  endCanary:uint32

type StageBindings* = object
  images*:array[12, Image]
  samplers*:array[8, Sampler]
  storageBuffers*:array[8, Buffer]

converter toStageBindingsimages*[N:static[int]](items: array[N, Image]): array[12, Image] =
  static: assert(N <= 12)
  for index,item in items.pairs: result[index]=item

converter toStageBindingssamplers*[N:static[int]](items: array[N, Sampler]): array[8, Sampler] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

converter toStageBindingsstorageBuffers*[N:static[int]](items: array[N, Buffer]): array[8, Buffer] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

type Bindings* = object
  startCanary:uint32
  vertexBuffers*:array[8, Buffer]
  vertexBufferOffsets*:array[8, int32]
  indexBuffer*:Buffer
  indexBufferOffset*:int32
  vs*:StageBindings
  fs*:StageBindings
  endCanary:uint32

converter toBindingsvertexBuffers*[N:static[int]](items: array[N, Buffer]): array[8, Buffer] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

converter toBindingsvertexBufferOffsets*[N:static[int]](items: array[N, int32]): array[8, int32] =
  static: assert(N <= 8)
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
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

converter toBufferDescmtlBuffers*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type ImageData* = object
  subimage*:array[6, array[16, Range]]

converter toImageDatasubimage*[Y:static[int], X:static[int]](items: array[Y, array[X, Range]]): array[6, array[16, Range]] =
  static: assert(X <= 16)
  static: assert(Y <= 6)
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
  data*:ImageData
  label*:cstring
  glTextures*:array[2, uint32]
  glTextureTarget*:uint32
  mtlTextures*:array[2, pointer]
  d3d11Texture*:pointer
  d3d11ShaderResourceView*:pointer
  wgpuTexture*:pointer
  wgpuTextureView*:pointer
  endCanary:uint32

converter toImageDescglTextures*[N:static[int]](items: array[N, uint32]): array[2, uint32] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

converter toImageDescmtlTextures*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type SamplerDesc* = object
  startCanary:uint32
  minFilter*:Filter
  magFilter*:Filter
  mipmapFilter*:Filter
  wrapU*:Wrap
  wrapV*:Wrap
  wrapW*:Wrap
  minLod*:float32
  maxLod*:float32
  borderColor*:BorderColor
  compare*:CompareFunc
  maxAnisotropy*:uint32
  label*:cstring
  glSampler*:uint32
  mtlSampler*:pointer
  d3d11Sampler*:pointer
  wgpuSampler*:pointer
  endCanary:uint32

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
  static: assert(N <= 16)
  for index,item in items.pairs: result[index]=item

type ShaderStorageBufferDesc* = object
  used*:bool
  readonly*:bool

type ShaderImageDesc* = object
  used*:bool
  multisampled*:bool
  imageType*:ImageType
  sampleType*:ImageSampleType

type ShaderSamplerDesc* = object
  used*:bool
  samplerType*:SamplerType

type ShaderImageSamplerPairDesc* = object
  used*:bool
  imageSlot*:int32
  samplerSlot*:int32
  glslName*:cstring

type ShaderStageDesc* = object
  source*:cstring
  bytecode*:Range
  entry*:cstring
  d3d11Target*:cstring
  uniformBlocks*:array[4, ShaderUniformBlockDesc]
  storageBuffers*:array[8, ShaderStorageBufferDesc]
  images*:array[12, ShaderImageDesc]
  samplers*:array[8, ShaderSamplerDesc]
  imageSamplerPairs*:array[12, ShaderImageSamplerPairDesc]

converter toShaderStageDescuniformBlocks*[N:static[int]](items: array[N, ShaderUniformBlockDesc]): array[4, ShaderUniformBlockDesc] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

converter toShaderStageDescstorageBuffers*[N:static[int]](items: array[N, ShaderStorageBufferDesc]): array[8, ShaderStorageBufferDesc] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

converter toShaderStageDescimages*[N:static[int]](items: array[N, ShaderImageDesc]): array[12, ShaderImageDesc] =
  static: assert(N <= 12)
  for index,item in items.pairs: result[index]=item

converter toShaderStageDescsamplers*[N:static[int]](items: array[N, ShaderSamplerDesc]): array[8, ShaderSamplerDesc] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

converter toShaderStageDescimageSamplerPairs*[N:static[int]](items: array[N, ShaderImageSamplerPairDesc]): array[12, ShaderImageSamplerPairDesc] =
  static: assert(N <= 12)
  for index,item in items.pairs: result[index]=item

type ShaderDesc* = object
  startCanary:uint32
  attrs*:array[16, ShaderAttrDesc]
  vs*:ShaderStageDesc
  fs*:ShaderStageDesc
  label*:cstring
  endCanary:uint32

converter toShaderDescattrs*[N:static[int]](items: array[N, ShaderAttrDesc]): array[16, ShaderAttrDesc] =
  static: assert(N <= 16)
  for index,item in items.pairs: result[index]=item

type VertexBufferLayoutState* = object
  stride*:int32
  stepFunc*:VertexStep
  stepRate*:int32

type VertexAttrState* = object
  bufferIndex*:int32
  offset*:int32
  format*:VertexFormat

type VertexLayoutState* = object
  buffers*:array[8, VertexBufferLayoutState]
  attrs*:array[16, VertexAttrState]

converter toVertexLayoutStatebuffers*[N:static[int]](items: array[N, VertexBufferLayoutState]): array[8, VertexBufferLayoutState] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

converter toVertexLayoutStateattrs*[N:static[int]](items: array[N, VertexAttrState]): array[16, VertexAttrState] =
  static: assert(N <= 16)
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

type ColorTargetState* = object
  pixelFormat*:PixelFormat
  writeMask*:ColorMask
  blend*:BlendState

type PipelineDesc* = object
  startCanary:uint32
  shader*:Shader
  layout*:VertexLayoutState
  depth*:DepthState
  stencil*:StencilState
  colorCount*:int32
  colors*:array[4, ColorTargetState]
  primitiveType*:PrimitiveType
  indexType*:IndexType
  cullMode*:CullMode
  faceWinding*:FaceWinding
  sampleCount*:int32
  blendColor*:Color
  alphaToCoverageEnabled*:bool
  label*:cstring
  endCanary:uint32

converter toPipelineDesccolors*[N:static[int]](items: array[N, ColorTargetState]): array[4, ColorTargetState] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type AttachmentDesc* = object
  image*:Image
  mipLevel*:int32
  slice*:int32

type AttachmentsDesc* = object
  startCanary:uint32
  colors*:array[4, AttachmentDesc]
  resolves*:array[4, AttachmentDesc]
  depthStencil*:AttachmentDesc
  label*:cstring
  endCanary:uint32

converter toAttachmentsDesccolors*[N:static[int]](items: array[N, AttachmentDesc]): array[4, AttachmentDesc] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

converter toAttachmentsDescresolves*[N:static[int]](items: array[N, AttachmentDesc]): array[4, AttachmentDesc] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type TraceHooks* = object
  userData*:pointer
  resetStateCache*:proc(a1:pointer) {.cdecl.}
  makeBuffer*:proc(a1:ptr BufferDesc, a2:Buffer, a3:pointer) {.cdecl.}
  makeImage*:proc(a1:ptr ImageDesc, a2:Image, a3:pointer) {.cdecl.}
  makeSampler*:proc(a1:ptr SamplerDesc, a2:Sampler, a3:pointer) {.cdecl.}
  makeShader*:proc(a1:ptr ShaderDesc, a2:Shader, a3:pointer) {.cdecl.}
  makePipeline*:proc(a1:ptr PipelineDesc, a2:Pipeline, a3:pointer) {.cdecl.}
  makeAttachments*:proc(a1:ptr AttachmentsDesc, a2:Attachments, a3:pointer) {.cdecl.}
  destroyBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  destroyImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  destroySampler*:proc(a1:Sampler, a2:pointer) {.cdecl.}
  destroyShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  destroyPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  destroyAttachments*:proc(a1:Attachments, a2:pointer) {.cdecl.}
  updateBuffer*:proc(a1:Buffer, a2:ptr Range, a3:pointer) {.cdecl.}
  updateImage*:proc(a1:Image, a2:ptr ImageData, a3:pointer) {.cdecl.}
  appendBuffer*:proc(a1:Buffer, a2:ptr Range, a3:int32, a4:pointer) {.cdecl.}
  beginPass*:proc(a1:ptr Pass, a2:pointer) {.cdecl.}
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
  allocSampler*:proc(a1:Sampler, a2:pointer) {.cdecl.}
  allocShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  allocPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  allocAttachments*:proc(a1:Attachments, a2:pointer) {.cdecl.}
  deallocBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  deallocImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  deallocSampler*:proc(a1:Sampler, a2:pointer) {.cdecl.}
  deallocShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  deallocPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  deallocAttachments*:proc(a1:Attachments, a2:pointer) {.cdecl.}
  initBuffer*:proc(a1:Buffer, a2:ptr BufferDesc, a3:pointer) {.cdecl.}
  initImage*:proc(a1:Image, a2:ptr ImageDesc, a3:pointer) {.cdecl.}
  initSampler*:proc(a1:Sampler, a2:ptr SamplerDesc, a3:pointer) {.cdecl.}
  initShader*:proc(a1:Shader, a2:ptr ShaderDesc, a3:pointer) {.cdecl.}
  initPipeline*:proc(a1:Pipeline, a2:ptr PipelineDesc, a3:pointer) {.cdecl.}
  initAttachments*:proc(a1:Attachments, a2:ptr AttachmentsDesc, a3:pointer) {.cdecl.}
  uninitBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  uninitImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  uninitSampler*:proc(a1:Sampler, a2:pointer) {.cdecl.}
  uninitShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  uninitPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  uninitAttachments*:proc(a1:Attachments, a2:pointer) {.cdecl.}
  failBuffer*:proc(a1:Buffer, a2:pointer) {.cdecl.}
  failImage*:proc(a1:Image, a2:pointer) {.cdecl.}
  failSampler*:proc(a1:Sampler, a2:pointer) {.cdecl.}
  failShader*:proc(a1:Shader, a2:pointer) {.cdecl.}
  failPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  failAttachments*:proc(a1:Attachments, a2:pointer) {.cdecl.}
  pushDebugGroup*:proc(a1:cstring, a2:pointer) {.cdecl.}
  popDebugGroup*:proc(a1:pointer) {.cdecl.}

type SlotInfo* = object
  state*:ResourceState
  resId*:uint32

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

type SamplerInfo* = object
  slot*:SlotInfo

type ShaderInfo* = object
  slot*:SlotInfo

type PipelineInfo* = object
  slot*:SlotInfo

type AttachmentsInfo* = object
  slot*:SlotInfo

type FrameStatsGl* = object
  numBindBuffer*:uint32
  numActiveTexture*:uint32
  numBindTexture*:uint32
  numBindSampler*:uint32
  numUseProgram*:uint32
  numRenderState*:uint32
  numVertexAttribPointer*:uint32
  numVertexAttribDivisor*:uint32
  numEnableVertexAttribArray*:uint32
  numDisableVertexAttribArray*:uint32
  numUniform*:uint32

type FrameStatsD3d11Pass* = object
  numOmSetRenderTargets*:uint32
  numClearRenderTargetView*:uint32
  numClearDepthStencilView*:uint32
  numResolveSubresource*:uint32

type FrameStatsD3d11Pipeline* = object
  numRsSetState*:uint32
  numOmSetDepthStencilState*:uint32
  numOmSetBlendState*:uint32
  numIaSetPrimitiveTopology*:uint32
  numIaSetInputLayout*:uint32
  numVsSetShader*:uint32
  numVsSetConstantBuffers*:uint32
  numPsSetShader*:uint32
  numPsSetConstantBuffers*:uint32

type FrameStatsD3d11Bindings* = object
  numIaSetVertexBuffers*:uint32
  numIaSetIndexBuffer*:uint32
  numVsSetShaderResources*:uint32
  numPsSetShaderResources*:uint32
  numVsSetSamplers*:uint32
  numPsSetSamplers*:uint32

type FrameStatsD3d11Uniforms* = object
  numUpdateSubresource*:uint32

type FrameStatsD3d11Draw* = object
  numDrawIndexedInstanced*:uint32
  numDrawIndexed*:uint32
  numDrawInstanced*:uint32
  numDraw*:uint32

type FrameStatsD3d11* = object
  pass*:FrameStatsD3d11Pass
  pipeline*:FrameStatsD3d11Pipeline
  bindings*:FrameStatsD3d11Bindings
  uniforms*:FrameStatsD3d11Uniforms
  draw*:FrameStatsD3d11Draw
  numMap*:uint32
  numUnmap*:uint32

type FrameStatsMetalIdpool* = object
  numAdded*:uint32
  numReleased*:uint32
  numGarbageCollected*:uint32

type FrameStatsMetalPipeline* = object
  numSetBlendColor*:uint32
  numSetCullMode*:uint32
  numSetFrontFacingWinding*:uint32
  numSetStencilReferenceValue*:uint32
  numSetDepthBias*:uint32
  numSetRenderPipelineState*:uint32
  numSetDepthStencilState*:uint32

type FrameStatsMetalBindings* = object
  numSetVertexBuffer*:uint32
  numSetVertexTexture*:uint32
  numSetVertexSamplerState*:uint32
  numSetFragmentBuffer*:uint32
  numSetFragmentTexture*:uint32
  numSetFragmentSamplerState*:uint32

type FrameStatsMetalUniforms* = object
  numSetVertexBufferOffset*:uint32
  numSetFragmentBufferOffset*:uint32

type FrameStatsMetal* = object
  idpool*:FrameStatsMetalIdpool
  pipeline*:FrameStatsMetalPipeline
  bindings*:FrameStatsMetalBindings
  uniforms*:FrameStatsMetalUniforms

type FrameStatsWgpuUniforms* = object
  numSetBindgroup*:uint32
  sizeWriteBuffer*:uint32

type FrameStatsWgpuBindings* = object
  numSetVertexBuffer*:uint32
  numSkipRedundantVertexBuffer*:uint32
  numSetIndexBuffer*:uint32
  numSkipRedundantIndexBuffer*:uint32
  numCreateBindgroup*:uint32
  numDiscardBindgroup*:uint32
  numSetBindgroup*:uint32
  numSkipRedundantBindgroup*:uint32
  numBindgroupCacheHits*:uint32
  numBindgroupCacheMisses*:uint32
  numBindgroupCacheCollisions*:uint32
  numBindgroupCacheHashVsKeyMismatch*:uint32

type FrameStatsWgpu* = object
  uniforms*:FrameStatsWgpuUniforms
  bindings*:FrameStatsWgpuBindings

type FrameStats* = object
  frameIndex*:uint32
  numPasses*:uint32
  numApplyViewport*:uint32
  numApplyScissorRect*:uint32
  numApplyPipeline*:uint32
  numApplyBindings*:uint32
  numApplyUniforms*:uint32
  numDraw*:uint32
  numUpdateBuffer*:uint32
  numAppendBuffer*:uint32
  numUpdateImage*:uint32
  sizeApplyUniforms*:uint32
  sizeUpdateBuffer*:uint32
  sizeAppendBuffer*:uint32
  sizeUpdateImage*:uint32
  gl*:FrameStatsGl
  d3d11*:FrameStatsD3d11
  metal*:FrameStatsMetal
  wgpu*:FrameStatsWgpu

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
    logitemGlFramebufferStatusUndefined,
    logitemGlFramebufferStatusIncompleteAttachment,
    logitemGlFramebufferStatusIncompleteMissingAttachment,
    logitemGlFramebufferStatusUnsupported,
    logitemGlFramebufferStatusIncompleteMultisample,
    logitemGlFramebufferStatusUnknown,
    logitemD3d11CreateBufferFailed,
    logitemD3d11CreateBufferSrvFailed,
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
    logitemMetalCreateBufferFailed,
    logitemMetalTextureFormatNotSupported,
    logitemMetalCreateTextureFailed,
    logitemMetalCreateSamplerFailed,
    logitemMetalShaderCompilationFailed,
    logitemMetalShaderCreationFailed,
    logitemMetalShaderCompilationOutput,
    logitemMetalVertexShaderEntryNotFound,
    logitemMetalFragmentShaderEntryNotFound,
    logitemMetalCreateRpsFailed,
    logitemMetalCreateRpsOutput,
    logitemMetalCreateDssFailed,
    logitemWgpuBindgroupsPoolExhausted,
    logitemWgpuBindgroupscacheSizeGreaterOne,
    logitemWgpuBindgroupscacheSizePow2,
    logitemWgpuCreatebindgroupFailed,
    logitemWgpuCreateBufferFailed,
    logitemWgpuCreateTextureFailed,
    logitemWgpuCreateTextureViewFailed,
    logitemWgpuCreateSamplerFailed,
    logitemWgpuCreateShaderModuleFailed,
    logitemWgpuShaderTooManyImages,
    logitemWgpuShaderTooManySamplers,
    logitemWgpuShaderTooManyStoragebuffers,
    logitemWgpuShaderCreateBindgroupLayoutFailed,
    logitemWgpuCreatePipelineLayoutFailed,
    logitemWgpuCreateRenderPipelineFailed,
    logitemWgpuAttachmentsCreateTextureViewFailed,
    logitemIdenticalCommitListener,
    logitemCommitListenerArrayFull,
    logitemTraceHooksNotEnabled,
    logitemDeallocBufferInvalidState,
    logitemDeallocImageInvalidState,
    logitemDeallocSamplerInvalidState,
    logitemDeallocShaderInvalidState,
    logitemDeallocPipelineInvalidState,
    logitemDeallocAttachmentsInvalidState,
    logitemInitBufferInvalidState,
    logitemInitImageInvalidState,
    logitemInitSamplerInvalidState,
    logitemInitShaderInvalidState,
    logitemInitPipelineInvalidState,
    logitemInitAttachmentsInvalidState,
    logitemUninitBufferInvalidState,
    logitemUninitImageInvalidState,
    logitemUninitSamplerInvalidState,
    logitemUninitShaderInvalidState,
    logitemUninitPipelineInvalidState,
    logitemUninitAttachmentsInvalidState,
    logitemFailBufferInvalidState,
    logitemFailImageInvalidState,
    logitemFailSamplerInvalidState,
    logitemFailShaderInvalidState,
    logitemFailPipelineInvalidState,
    logitemFailAttachmentsInvalidState,
    logitemBufferPoolExhausted,
    logitemImagePoolExhausted,
    logitemSamplerPoolExhausted,
    logitemShaderPoolExhausted,
    logitemPipelinePoolExhausted,
    logitemPassPoolExhausted,
    logitemBeginpassAttachmentInvalid,
    logitemDrawWithoutBindings,
    logitemValidateBufferdescCanary,
    logitemValidateBufferdescSize,
    logitemValidateBufferdescData,
    logitemValidateBufferdescDataSize,
    logitemValidateBufferdescNoData,
    logitemValidateBufferdescStoragebufferSupported,
    logitemValidateBufferdescStoragebufferSizeMultiple4,
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
    logitemValidateSamplerdescCanary,
    logitemValidateSamplerdescMinfilterNone,
    logitemValidateSamplerdescMagfilterNone,
    logitemValidateSamplerdescAnistropicRequiresLinearFiltering,
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
    logitemValidateShaderdescNoContStoragebuffers,
    logitemValidateShaderdescStoragebufferReadonly,
    logitemValidateShaderdescNoContImages,
    logitemValidateShaderdescNoContSamplers,
    logitemValidateShaderdescImageSamplerPairImageSlotOutOfRange,
    logitemValidateShaderdescImageSamplerPairSamplerSlotOutOfRange,
    logitemValidateShaderdescImageSamplerPairNameRequiredForGl,
    logitemValidateShaderdescImageSamplerPairHasNameButNotUsed,
    logitemValidateShaderdescImageSamplerPairHasImageButNotUsed,
    logitemValidateShaderdescImageSamplerPairHasSamplerButNotUsed,
    logitemValidateShaderdescNonfilteringSamplerRequired,
    logitemValidateShaderdescComparisonSamplerRequired,
    logitemValidateShaderdescImageNotReferencedByImageSamplerPairs,
    logitemValidateShaderdescSamplerNotReferencedByImageSamplerPairs,
    logitemValidateShaderdescNoContImageSamplerPairs,
    logitemValidateShaderdescAttrStringTooLong,
    logitemValidatePipelinedescCanary,
    logitemValidatePipelinedescShader,
    logitemValidatePipelinedescNoContAttrs,
    logitemValidatePipelinedescLayoutStride4,
    logitemValidatePipelinedescAttrSemantics,
    logitemValidateAttachmentsdescCanary,
    logitemValidateAttachmentsdescNoAttachments,
    logitemValidateAttachmentsdescNoContColorAtts,
    logitemValidateAttachmentsdescImage,
    logitemValidateAttachmentsdescMiplevel,
    logitemValidateAttachmentsdescFace,
    logitemValidateAttachmentsdescLayer,
    logitemValidateAttachmentsdescSlice,
    logitemValidateAttachmentsdescImageNoRt,
    logitemValidateAttachmentsdescColorInvPixelformat,
    logitemValidateAttachmentsdescDepthInvPixelformat,
    logitemValidateAttachmentsdescImageSizes,
    logitemValidateAttachmentsdescImageSampleCounts,
    logitemValidateAttachmentsdescResolveColorImageMsaa,
    logitemValidateAttachmentsdescResolveImage,
    logitemValidateAttachmentsdescResolveSampleCount,
    logitemValidateAttachmentsdescResolveMiplevel,
    logitemValidateAttachmentsdescResolveFace,
    logitemValidateAttachmentsdescResolveLayer,
    logitemValidateAttachmentsdescResolveSlice,
    logitemValidateAttachmentsdescResolveImageNoRt,
    logitemValidateAttachmentsdescResolveImageSizes,
    logitemValidateAttachmentsdescResolveImageFormat,
    logitemValidateAttachmentsdescDepthImage,
    logitemValidateAttachmentsdescDepthMiplevel,
    logitemValidateAttachmentsdescDepthFace,
    logitemValidateAttachmentsdescDepthLayer,
    logitemValidateAttachmentsdescDepthSlice,
    logitemValidateAttachmentsdescDepthImageNoRt,
    logitemValidateAttachmentsdescDepthImageSizes,
    logitemValidateAttachmentsdescDepthImageSampleCount,
    logitemValidateBeginpassCanary,
    logitemValidateBeginpassAttachmentsExists,
    logitemValidateBeginpassAttachmentsValid,
    logitemValidateBeginpassColorAttachmentImage,
    logitemValidateBeginpassResolveAttachmentImage,
    logitemValidateBeginpassDepthstencilAttachmentImage,
    logitemValidateBeginpassSwapchainExpectWidth,
    logitemValidateBeginpassSwapchainExpectWidthNotset,
    logitemValidateBeginpassSwapchainExpectHeight,
    logitemValidateBeginpassSwapchainExpectHeightNotset,
    logitemValidateBeginpassSwapchainExpectSamplecount,
    logitemValidateBeginpassSwapchainExpectSamplecountNotset,
    logitemValidateBeginpassSwapchainExpectColorformat,
    logitemValidateBeginpassSwapchainExpectColorformatNotset,
    logitemValidateBeginpassSwapchainExpectDepthformatNotset,
    logitemValidateBeginpassSwapchainMetalExpectCurrentdrawable,
    logitemValidateBeginpassSwapchainMetalExpectCurrentdrawableNotset,
    logitemValidateBeginpassSwapchainMetalExpectDepthstenciltexture,
    logitemValidateBeginpassSwapchainMetalExpectDepthstenciltextureNotset,
    logitemValidateBeginpassSwapchainMetalExpectMsaacolortexture,
    logitemValidateBeginpassSwapchainMetalExpectMsaacolortextureNotset,
    logitemValidateBeginpassSwapchainD3d11ExpectRenderview,
    logitemValidateBeginpassSwapchainD3d11ExpectRenderviewNotset,
    logitemValidateBeginpassSwapchainD3d11ExpectResolveview,
    logitemValidateBeginpassSwapchainD3d11ExpectResolveviewNotset,
    logitemValidateBeginpassSwapchainD3d11ExpectDepthstencilview,
    logitemValidateBeginpassSwapchainD3d11ExpectDepthstencilviewNotset,
    logitemValidateBeginpassSwapchainWgpuExpectRenderview,
    logitemValidateBeginpassSwapchainWgpuExpectRenderviewNotset,
    logitemValidateBeginpassSwapchainWgpuExpectResolveview,
    logitemValidateBeginpassSwapchainWgpuExpectResolveviewNotset,
    logitemValidateBeginpassSwapchainWgpuExpectDepthstencilview,
    logitemValidateBeginpassSwapchainWgpuExpectDepthstencilviewNotset,
    logitemValidateBeginpassSwapchainGlExpectFramebufferNotset,
    logitemValidateApipPipelineValidId,
    logitemValidateApipPipelineExists,
    logitemValidateApipPipelineValid,
    logitemValidateApipShaderExists,
    logitemValidateApipShaderValid,
    logitemValidateApipCurpassAttachmentsExists,
    logitemValidateApipCurpassAttachmentsValid,
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
    logitemValidateAbndVsExpectedImageBinding,
    logitemValidateAbndVsImgExists,
    logitemValidateAbndVsImageTypeMismatch,
    logitemValidateAbndVsImageMsaa,
    logitemValidateAbndVsExpectedFilterableImage,
    logitemValidateAbndVsExpectedDepthImage,
    logitemValidateAbndVsUnexpectedImageBinding,
    logitemValidateAbndVsExpectedSamplerBinding,
    logitemValidateAbndVsUnexpectedSamplerCompareNever,
    logitemValidateAbndVsExpectedSamplerCompareNever,
    logitemValidateAbndVsExpectedNonfilteringSampler,
    logitemValidateAbndVsUnexpectedSamplerBinding,
    logitemValidateAbndVsSmpExists,
    logitemValidateAbndVsExpectedStoragebufferBinding,
    logitemValidateAbndVsStoragebufferExists,
    logitemValidateAbndVsStoragebufferBindingBuffertype,
    logitemValidateAbndVsUnexpectedStoragebufferBinding,
    logitemValidateAbndFsExpectedImageBinding,
    logitemValidateAbndFsImgExists,
    logitemValidateAbndFsImageTypeMismatch,
    logitemValidateAbndFsImageMsaa,
    logitemValidateAbndFsExpectedFilterableImage,
    logitemValidateAbndFsExpectedDepthImage,
    logitemValidateAbndFsUnexpectedImageBinding,
    logitemValidateAbndFsExpectedSamplerBinding,
    logitemValidateAbndFsUnexpectedSamplerCompareNever,
    logitemValidateAbndFsExpectedSamplerCompareNever,
    logitemValidateAbndFsExpectedNonfilteringSampler,
    logitemValidateAbndFsUnexpectedSamplerBinding,
    logitemValidateAbndFsSmpExists,
    logitemValidateAbndFsExpectedStoragebufferBinding,
    logitemValidateAbndFsStoragebufferExists,
    logitemValidateAbndFsStoragebufferBindingBuffertype,
    logitemValidateAbndFsUnexpectedStoragebufferBinding,
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

type EnvironmentDefaults* = object
  colorFormat*:PixelFormat
  depthFormat*:PixelFormat
  sampleCount*:int32

type MetalEnvironment* = object
  device*:pointer

type D3d11Environment* = object
  device*:pointer
  deviceContext*:pointer

type WgpuEnvironment* = object
  device*:pointer

type Environment* = object
  defaults*:EnvironmentDefaults
  metal*:MetalEnvironment
  d3d11*:D3d11Environment
  wgpu*:WgpuEnvironment

type CommitListener* = object
  fn*:proc(a1:pointer) {.cdecl.}
  userData*:pointer

type Allocator* = object
  allocFn*:proc(a1:int, a2:pointer):pointer {.cdecl.}
  freeFn*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Logger* = object
  fn*:proc(a1:cstring, a2:uint32, a3:uint32, a4:cstring, a5:uint32, a6:cstring, a7:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  startCanary:uint32
  bufferPoolSize*:int32
  imagePoolSize*:int32
  samplerPoolSize*:int32
  shaderPoolSize*:int32
  pipelinePoolSize*:int32
  attachmentsPoolSize*:int32
  uniformBufferSize*:int32
  maxCommitListeners*:int32
  disableValidation*:bool
  mtlForceManagedStorageMode*:bool
  mtlUseCommandBufferWithRetainedReferences*:bool
  wgpuDisableBindgroupsCache*:bool
  wgpuBindgroupsCacheSize*:int32
  allocator*:Allocator
  logger*:Logger
  environment*:Environment
  endCanary:uint32

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sg_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

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
    c_installTraceHooks(addr(trace_hooks))

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
    c_makeBuffer(addr(desc))

proc c_makeImage(desc:ptr ImageDesc):Image {.cdecl, importc:"sg_make_image".}
proc makeImage*(desc:ImageDesc):Image =
    c_makeImage(addr(desc))

proc c_makeSampler(desc:ptr SamplerDesc):Sampler {.cdecl, importc:"sg_make_sampler".}
proc makeSampler*(desc:SamplerDesc):Sampler =
    c_makeSampler(addr(desc))

proc c_makeShader(desc:ptr ShaderDesc):Shader {.cdecl, importc:"sg_make_shader".}
proc makeShader*(desc:ShaderDesc):Shader =
    c_makeShader(addr(desc))

proc c_makePipeline(desc:ptr PipelineDesc):Pipeline {.cdecl, importc:"sg_make_pipeline".}
proc makePipeline*(desc:PipelineDesc):Pipeline =
    c_makePipeline(addr(desc))

proc c_makeAttachments(desc:ptr AttachmentsDesc):Attachments {.cdecl, importc:"sg_make_attachments".}
proc makeAttachments*(desc:AttachmentsDesc):Attachments =
    c_makeAttachments(addr(desc))

proc c_destroyBuffer(buf:Buffer):void {.cdecl, importc:"sg_destroy_buffer".}
proc destroyBuffer*(buf:Buffer):void =
    c_destroyBuffer(buf)

proc c_destroyImage(img:Image):void {.cdecl, importc:"sg_destroy_image".}
proc destroyImage*(img:Image):void =
    c_destroyImage(img)

proc c_destroySampler(smp:Sampler):void {.cdecl, importc:"sg_destroy_sampler".}
proc destroySampler*(smp:Sampler):void =
    c_destroySampler(smp)

proc c_destroyShader(shd:Shader):void {.cdecl, importc:"sg_destroy_shader".}
proc destroyShader*(shd:Shader):void =
    c_destroyShader(shd)

proc c_destroyPipeline(pip:Pipeline):void {.cdecl, importc:"sg_destroy_pipeline".}
proc destroyPipeline*(pip:Pipeline):void =
    c_destroyPipeline(pip)

proc c_destroyAttachments(atts:Attachments):void {.cdecl, importc:"sg_destroy_attachments".}
proc destroyAttachments*(atts:Attachments):void =
    c_destroyAttachments(atts)

proc c_updateBuffer(buf:Buffer, data:ptr Range):void {.cdecl, importc:"sg_update_buffer".}
proc updateBuffer*(buf:Buffer, data:Range):void =
    c_updateBuffer(buf, addr(data))

proc c_updateImage(img:Image, data:ptr ImageData):void {.cdecl, importc:"sg_update_image".}
proc updateImage*(img:Image, data:ImageData):void =
    c_updateImage(img, addr(data))

proc c_appendBuffer(buf:Buffer, data:ptr Range):int32 {.cdecl, importc:"sg_append_buffer".}
proc appendBuffer*(buf:Buffer, data:Range):int32 =
    c_appendBuffer(buf, addr(data))

proc c_queryBufferOverflow(buf:Buffer):bool {.cdecl, importc:"sg_query_buffer_overflow".}
proc queryBufferOverflow*(buf:Buffer):bool =
    c_queryBufferOverflow(buf)

proc c_queryBufferWillOverflow(buf:Buffer, size:int):bool {.cdecl, importc:"sg_query_buffer_will_overflow".}
proc queryBufferWillOverflow*(buf:Buffer, size:int):bool =
    c_queryBufferWillOverflow(buf, size)

proc c_beginPass(pass:ptr Pass):void {.cdecl, importc:"sg_begin_pass".}
proc beginPass*(pass:Pass):void =
    c_beginPass(addr(pass))

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
    c_applyBindings(addr(bindings))

proc c_applyUniforms(stage:ShaderStage, ubIndex:int32, data:ptr Range):void {.cdecl, importc:"sg_apply_uniforms".}
proc applyUniforms*(stage:ShaderStage, ubIndex:int32, data:Range):void =
    c_applyUniforms(stage, ub_index, addr(data))

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

proc c_queryRowPitch(fmt:PixelFormat, width:int32, rowAlignBytes:int32):int32 {.cdecl, importc:"sg_query_row_pitch".}
proc queryRowPitch*(fmt:PixelFormat, width:int32, rowAlignBytes:int32):int32 =
    c_queryRowPitch(fmt, width, row_align_bytes)

proc c_querySurfacePitch(fmt:PixelFormat, width:int32, height:int32, rowAlignBytes:int32):int32 {.cdecl, importc:"sg_query_surface_pitch".}
proc querySurfacePitch*(fmt:PixelFormat, width:int32, height:int32, rowAlignBytes:int32):int32 =
    c_querySurfacePitch(fmt, width, height, row_align_bytes)

proc c_queryBufferState(buf:Buffer):ResourceState {.cdecl, importc:"sg_query_buffer_state".}
proc queryBufferState*(buf:Buffer):ResourceState =
    c_queryBufferState(buf)

proc c_queryImageState(img:Image):ResourceState {.cdecl, importc:"sg_query_image_state".}
proc queryImageState*(img:Image):ResourceState =
    c_queryImageState(img)

proc c_querySamplerState(smp:Sampler):ResourceState {.cdecl, importc:"sg_query_sampler_state".}
proc querySamplerState*(smp:Sampler):ResourceState =
    c_querySamplerState(smp)

proc c_queryShaderState(shd:Shader):ResourceState {.cdecl, importc:"sg_query_shader_state".}
proc queryShaderState*(shd:Shader):ResourceState =
    c_queryShaderState(shd)

proc c_queryPipelineState(pip:Pipeline):ResourceState {.cdecl, importc:"sg_query_pipeline_state".}
proc queryPipelineState*(pip:Pipeline):ResourceState =
    c_queryPipelineState(pip)

proc c_queryAttachmentsState(atts:Attachments):ResourceState {.cdecl, importc:"sg_query_attachments_state".}
proc queryAttachmentsState*(atts:Attachments):ResourceState =
    c_queryAttachmentsState(atts)

proc c_queryBufferInfo(buf:Buffer):BufferInfo {.cdecl, importc:"sg_query_buffer_info".}
proc queryBufferInfo*(buf:Buffer):BufferInfo =
    c_queryBufferInfo(buf)

proc c_queryImageInfo(img:Image):ImageInfo {.cdecl, importc:"sg_query_image_info".}
proc queryImageInfo*(img:Image):ImageInfo =
    c_queryImageInfo(img)

proc c_querySamplerInfo(smp:Sampler):SamplerInfo {.cdecl, importc:"sg_query_sampler_info".}
proc querySamplerInfo*(smp:Sampler):SamplerInfo =
    c_querySamplerInfo(smp)

proc c_queryShaderInfo(shd:Shader):ShaderInfo {.cdecl, importc:"sg_query_shader_info".}
proc queryShaderInfo*(shd:Shader):ShaderInfo =
    c_queryShaderInfo(shd)

proc c_queryPipelineInfo(pip:Pipeline):PipelineInfo {.cdecl, importc:"sg_query_pipeline_info".}
proc queryPipelineInfo*(pip:Pipeline):PipelineInfo =
    c_queryPipelineInfo(pip)

proc c_queryAttachmentsInfo(atts:Attachments):AttachmentsInfo {.cdecl, importc:"sg_query_attachments_info".}
proc queryAttachmentsInfo*(atts:Attachments):AttachmentsInfo =
    c_queryAttachmentsInfo(atts)

proc c_queryBufferDesc(buf:Buffer):BufferDesc {.cdecl, importc:"sg_query_buffer_desc".}
proc queryBufferDesc*(buf:Buffer):BufferDesc =
    c_queryBufferDesc(buf)

proc c_queryImageDesc(img:Image):ImageDesc {.cdecl, importc:"sg_query_image_desc".}
proc queryImageDesc*(img:Image):ImageDesc =
    c_queryImageDesc(img)

proc c_querySamplerDesc(smp:Sampler):SamplerDesc {.cdecl, importc:"sg_query_sampler_desc".}
proc querySamplerDesc*(smp:Sampler):SamplerDesc =
    c_querySamplerDesc(smp)

proc c_queryShaderDesc(shd:Shader):ShaderDesc {.cdecl, importc:"sg_query_shader_desc".}
proc queryShaderDesc*(shd:Shader):ShaderDesc =
    c_queryShaderDesc(shd)

proc c_queryPipelineDesc(pip:Pipeline):PipelineDesc {.cdecl, importc:"sg_query_pipeline_desc".}
proc queryPipelineDesc*(pip:Pipeline):PipelineDesc =
    c_queryPipelineDesc(pip)

proc c_queryAttachmentsDesc(atts:Attachments):AttachmentsDesc {.cdecl, importc:"sg_query_attachments_desc".}
proc queryAttachmentsDesc*(atts:Attachments):AttachmentsDesc =
    c_queryAttachmentsDesc(atts)

proc c_queryBufferDefaults(desc:ptr BufferDesc):BufferDesc {.cdecl, importc:"sg_query_buffer_defaults".}
proc queryBufferDefaults*(desc:BufferDesc):BufferDesc =
    c_queryBufferDefaults(addr(desc))

proc c_queryImageDefaults(desc:ptr ImageDesc):ImageDesc {.cdecl, importc:"sg_query_image_defaults".}
proc queryImageDefaults*(desc:ImageDesc):ImageDesc =
    c_queryImageDefaults(addr(desc))

proc c_querySamplerDefaults(desc:ptr SamplerDesc):SamplerDesc {.cdecl, importc:"sg_query_sampler_defaults".}
proc querySamplerDefaults*(desc:SamplerDesc):SamplerDesc =
    c_querySamplerDefaults(addr(desc))

proc c_queryShaderDefaults(desc:ptr ShaderDesc):ShaderDesc {.cdecl, importc:"sg_query_shader_defaults".}
proc queryShaderDefaults*(desc:ShaderDesc):ShaderDesc =
    c_queryShaderDefaults(addr(desc))

proc c_queryPipelineDefaults(desc:ptr PipelineDesc):PipelineDesc {.cdecl, importc:"sg_query_pipeline_defaults".}
proc queryPipelineDefaults*(desc:PipelineDesc):PipelineDesc =
    c_queryPipelineDefaults(addr(desc))

proc c_queryAttachmentsDefaults(desc:ptr AttachmentsDesc):AttachmentsDesc {.cdecl, importc:"sg_query_attachments_defaults".}
proc queryAttachmentsDefaults*(desc:AttachmentsDesc):AttachmentsDesc =
    c_queryAttachmentsDefaults(addr(desc))

proc c_allocBuffer():Buffer {.cdecl, importc:"sg_alloc_buffer".}
proc allocBuffer*():Buffer =
    c_allocBuffer()

proc c_allocImage():Image {.cdecl, importc:"sg_alloc_image".}
proc allocImage*():Image =
    c_allocImage()

proc c_allocSampler():Sampler {.cdecl, importc:"sg_alloc_sampler".}
proc allocSampler*():Sampler =
    c_allocSampler()

proc c_allocShader():Shader {.cdecl, importc:"sg_alloc_shader".}
proc allocShader*():Shader =
    c_allocShader()

proc c_allocPipeline():Pipeline {.cdecl, importc:"sg_alloc_pipeline".}
proc allocPipeline*():Pipeline =
    c_allocPipeline()

proc c_allocAttachments():Attachments {.cdecl, importc:"sg_alloc_attachments".}
proc allocAttachments*():Attachments =
    c_allocAttachments()

proc c_deallocBuffer(buf:Buffer):void {.cdecl, importc:"sg_dealloc_buffer".}
proc deallocBuffer*(buf:Buffer):void =
    c_deallocBuffer(buf)

proc c_deallocImage(img:Image):void {.cdecl, importc:"sg_dealloc_image".}
proc deallocImage*(img:Image):void =
    c_deallocImage(img)

proc c_deallocSampler(smp:Sampler):void {.cdecl, importc:"sg_dealloc_sampler".}
proc deallocSampler*(smp:Sampler):void =
    c_deallocSampler(smp)

proc c_deallocShader(shd:Shader):void {.cdecl, importc:"sg_dealloc_shader".}
proc deallocShader*(shd:Shader):void =
    c_deallocShader(shd)

proc c_deallocPipeline(pip:Pipeline):void {.cdecl, importc:"sg_dealloc_pipeline".}
proc deallocPipeline*(pip:Pipeline):void =
    c_deallocPipeline(pip)

proc c_deallocAttachments(attachments:Attachments):void {.cdecl, importc:"sg_dealloc_attachments".}
proc deallocAttachments*(attachments:Attachments):void =
    c_deallocAttachments(attachments)

proc c_initBuffer(buf:Buffer, desc:ptr BufferDesc):void {.cdecl, importc:"sg_init_buffer".}
proc initBuffer*(buf:Buffer, desc:BufferDesc):void =
    c_initBuffer(buf, addr(desc))

proc c_initImage(img:Image, desc:ptr ImageDesc):void {.cdecl, importc:"sg_init_image".}
proc initImage*(img:Image, desc:ImageDesc):void =
    c_initImage(img, addr(desc))

proc c_initSampler(smg:Sampler, desc:ptr SamplerDesc):void {.cdecl, importc:"sg_init_sampler".}
proc initSampler*(smg:Sampler, desc:SamplerDesc):void =
    c_initSampler(smg, addr(desc))

proc c_initShader(shd:Shader, desc:ptr ShaderDesc):void {.cdecl, importc:"sg_init_shader".}
proc initShader*(shd:Shader, desc:ShaderDesc):void =
    c_initShader(shd, addr(desc))

proc c_initPipeline(pip:Pipeline, desc:ptr PipelineDesc):void {.cdecl, importc:"sg_init_pipeline".}
proc initPipeline*(pip:Pipeline, desc:PipelineDesc):void =
    c_initPipeline(pip, addr(desc))

proc c_initAttachments(attachments:Attachments, desc:ptr AttachmentsDesc):void {.cdecl, importc:"sg_init_attachments".}
proc initAttachments*(attachments:Attachments, desc:AttachmentsDesc):void =
    c_initAttachments(attachments, addr(desc))

proc c_uninitBuffer(buf:Buffer):void {.cdecl, importc:"sg_uninit_buffer".}
proc uninitBuffer*(buf:Buffer):void =
    c_uninitBuffer(buf)

proc c_uninitImage(img:Image):void {.cdecl, importc:"sg_uninit_image".}
proc uninitImage*(img:Image):void =
    c_uninitImage(img)

proc c_uninitSampler(smp:Sampler):void {.cdecl, importc:"sg_uninit_sampler".}
proc uninitSampler*(smp:Sampler):void =
    c_uninitSampler(smp)

proc c_uninitShader(shd:Shader):void {.cdecl, importc:"sg_uninit_shader".}
proc uninitShader*(shd:Shader):void =
    c_uninitShader(shd)

proc c_uninitPipeline(pip:Pipeline):void {.cdecl, importc:"sg_uninit_pipeline".}
proc uninitPipeline*(pip:Pipeline):void =
    c_uninitPipeline(pip)

proc c_uninitAttachments(atts:Attachments):void {.cdecl, importc:"sg_uninit_attachments".}
proc uninitAttachments*(atts:Attachments):void =
    c_uninitAttachments(atts)

proc c_failBuffer(buf:Buffer):void {.cdecl, importc:"sg_fail_buffer".}
proc failBuffer*(buf:Buffer):void =
    c_failBuffer(buf)

proc c_failImage(img:Image):void {.cdecl, importc:"sg_fail_image".}
proc failImage*(img:Image):void =
    c_failImage(img)

proc c_failSampler(smp:Sampler):void {.cdecl, importc:"sg_fail_sampler".}
proc failSampler*(smp:Sampler):void =
    c_failSampler(smp)

proc c_failShader(shd:Shader):void {.cdecl, importc:"sg_fail_shader".}
proc failShader*(shd:Shader):void =
    c_failShader(shd)

proc c_failPipeline(pip:Pipeline):void {.cdecl, importc:"sg_fail_pipeline".}
proc failPipeline*(pip:Pipeline):void =
    c_failPipeline(pip)

proc c_failAttachments(atts:Attachments):void {.cdecl, importc:"sg_fail_attachments".}
proc failAttachments*(atts:Attachments):void =
    c_failAttachments(atts)

proc c_enableFrameStats():void {.cdecl, importc:"sg_enable_frame_stats".}
proc enableFrameStats*():void =
    c_enableFrameStats()

proc c_disableFrameStats():void {.cdecl, importc:"sg_disable_frame_stats".}
proc disableFrameStats*():void =
    c_disableFrameStats()

proc c_frameStatsEnabled():bool {.cdecl, importc:"sg_frame_stats_enabled".}
proc frameStatsEnabled*():bool =
    c_frameStatsEnabled()

proc c_queryFrameStats():FrameStats {.cdecl, importc:"sg_query_frame_stats".}
proc queryFrameStats*():FrameStats =
    c_queryFrameStats()

type D3d11BufferInfo* = object
  buf*:pointer

type D3d11ImageInfo* = object
  tex2d*:pointer
  tex3d*:pointer
  res*:pointer
  srv*:pointer

type D3d11SamplerInfo* = object
  smp*:pointer

type D3d11ShaderInfo* = object
  vsCbufs*:array[4, pointer]
  fsCbufs*:array[4, pointer]
  vs*:pointer
  fs*:pointer

converter toD3d11ShaderInfovsCbufs*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

converter toD3d11ShaderInfofsCbufs*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type D3d11PipelineInfo* = object
  il*:pointer
  rs*:pointer
  dss*:pointer
  bs*:pointer

type D3d11AttachmentsInfo* = object
  colorRtv*:array[4, pointer]
  resolveRtv*:array[4, pointer]
  dsv*:pointer

converter toD3d11AttachmentsInfocolorRtv*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

converter toD3d11AttachmentsInforesolveRtv*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type MtlBufferInfo* = object
  buf*:array[2, pointer]
  activeSlot*:int32

converter toMtlBufferInfobuf*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type MtlImageInfo* = object
  tex*:array[2, pointer]
  activeSlot*:int32

converter toMtlImageInfotex*[N:static[int]](items: array[N, pointer]): array[2, pointer] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type MtlSamplerInfo* = object
  smp*:pointer

type MtlShaderInfo* = object
  vsLib*:pointer
  fsLib*:pointer
  vsFunc*:pointer
  fsFunc*:pointer

type MtlPipelineInfo* = object
  rps*:pointer
  dss*:pointer

type WgpuBufferInfo* = object
  buf*:pointer

type WgpuImageInfo* = object
  tex*:pointer
  view*:pointer

type WgpuSamplerInfo* = object
  smp*:pointer

type WgpuShaderInfo* = object
  vsMod*:pointer
  fsMod*:pointer
  bgl*:pointer

type WgpuPipelineInfo* = object
  pip*:pointer

type WgpuAttachmentsInfo* = object
  colorView*:array[4, pointer]
  resolveView*:array[4, pointer]
  dsView*:pointer

converter toWgpuAttachmentsInfocolorView*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

converter toWgpuAttachmentsInforesolveView*[N:static[int]](items: array[N, pointer]): array[4, pointer] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

type GlBufferInfo* = object
  buf*:array[2, uint32]
  activeSlot*:int32

converter toGlBufferInfobuf*[N:static[int]](items: array[N, uint32]): array[2, uint32] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type GlImageInfo* = object
  tex*:array[2, uint32]
  texTarget*:uint32
  msaaRenderBuffer*:uint32
  activeSlot*:int32

converter toGlImageInfotex*[N:static[int]](items: array[N, uint32]): array[2, uint32] =
  static: assert(N <= 2)
  for index,item in items.pairs: result[index]=item

type GlSamplerInfo* = object
  smp*:uint32

type GlShaderInfo* = object
  prog*:uint32

type GlAttachmentsInfo* = object
  framebuffer*:uint32
  msaaResolveFramebuffer*:array[4, uint32]

converter toGlAttachmentsInfomsaaResolveFramebuffer*[N:static[int]](items: array[N, uint32]): array[4, uint32] =
  static: assert(N <= 4)
  for index,item in items.pairs: result[index]=item

proc c_d3d11Device():pointer {.cdecl, importc:"sg_d3d11_device".}
proc d3d11Device*():pointer =
    c_d3d11Device()

proc c_d3d11DeviceContext():pointer {.cdecl, importc:"sg_d3d11_device_context".}
proc d3d11DeviceContext*():pointer =
    c_d3d11DeviceContext()

proc c_d3d11QueryBufferInfo(buf:Buffer):D3d11BufferInfo {.cdecl, importc:"sg_d3d11_query_buffer_info".}
proc d3d11QueryBufferInfo*(buf:Buffer):D3d11BufferInfo =
    c_d3d11QueryBufferInfo(buf)

proc c_d3d11QueryImageInfo(img:Image):D3d11ImageInfo {.cdecl, importc:"sg_d3d11_query_image_info".}
proc d3d11QueryImageInfo*(img:Image):D3d11ImageInfo =
    c_d3d11QueryImageInfo(img)

proc c_d3d11QuerySamplerInfo(smp:Sampler):D3d11SamplerInfo {.cdecl, importc:"sg_d3d11_query_sampler_info".}
proc d3d11QuerySamplerInfo*(smp:Sampler):D3d11SamplerInfo =
    c_d3d11QuerySamplerInfo(smp)

proc c_d3d11QueryShaderInfo(shd:Shader):D3d11ShaderInfo {.cdecl, importc:"sg_d3d11_query_shader_info".}
proc d3d11QueryShaderInfo*(shd:Shader):D3d11ShaderInfo =
    c_d3d11QueryShaderInfo(shd)

proc c_d3d11QueryPipelineInfo(pip:Pipeline):D3d11PipelineInfo {.cdecl, importc:"sg_d3d11_query_pipeline_info".}
proc d3d11QueryPipelineInfo*(pip:Pipeline):D3d11PipelineInfo =
    c_d3d11QueryPipelineInfo(pip)

proc c_d3d11QueryAttachmentsInfo(atts:Attachments):D3d11AttachmentsInfo {.cdecl, importc:"sg_d3d11_query_attachments_info".}
proc d3d11QueryAttachmentsInfo*(atts:Attachments):D3d11AttachmentsInfo =
    c_d3d11QueryAttachmentsInfo(atts)

proc c_mtlDevice():pointer {.cdecl, importc:"sg_mtl_device".}
proc mtlDevice*():pointer =
    c_mtlDevice()

proc c_mtlRenderCommandEncoder():pointer {.cdecl, importc:"sg_mtl_render_command_encoder".}
proc mtlRenderCommandEncoder*():pointer =
    c_mtlRenderCommandEncoder()

proc c_mtlQueryBufferInfo(buf:Buffer):MtlBufferInfo {.cdecl, importc:"sg_mtl_query_buffer_info".}
proc mtlQueryBufferInfo*(buf:Buffer):MtlBufferInfo =
    c_mtlQueryBufferInfo(buf)

proc c_mtlQueryImageInfo(img:Image):MtlImageInfo {.cdecl, importc:"sg_mtl_query_image_info".}
proc mtlQueryImageInfo*(img:Image):MtlImageInfo =
    c_mtlQueryImageInfo(img)

proc c_mtlQuerySamplerInfo(smp:Sampler):MtlSamplerInfo {.cdecl, importc:"sg_mtl_query_sampler_info".}
proc mtlQuerySamplerInfo*(smp:Sampler):MtlSamplerInfo =
    c_mtlQuerySamplerInfo(smp)

proc c_mtlQueryShaderInfo(shd:Shader):MtlShaderInfo {.cdecl, importc:"sg_mtl_query_shader_info".}
proc mtlQueryShaderInfo*(shd:Shader):MtlShaderInfo =
    c_mtlQueryShaderInfo(shd)

proc c_mtlQueryPipelineInfo(pip:Pipeline):MtlPipelineInfo {.cdecl, importc:"sg_mtl_query_pipeline_info".}
proc mtlQueryPipelineInfo*(pip:Pipeline):MtlPipelineInfo =
    c_mtlQueryPipelineInfo(pip)

proc c_wgpuDevice():pointer {.cdecl, importc:"sg_wgpu_device".}
proc wgpuDevice*():pointer =
    c_wgpuDevice()

proc c_wgpuQueue():pointer {.cdecl, importc:"sg_wgpu_queue".}
proc wgpuQueue*():pointer =
    c_wgpuQueue()

proc c_wgpuCommandEncoder():pointer {.cdecl, importc:"sg_wgpu_command_encoder".}
proc wgpuCommandEncoder*():pointer =
    c_wgpuCommandEncoder()

proc c_wgpuRenderPassEncoder():pointer {.cdecl, importc:"sg_wgpu_render_pass_encoder".}
proc wgpuRenderPassEncoder*():pointer =
    c_wgpuRenderPassEncoder()

proc c_wgpuQueryBufferInfo(buf:Buffer):WgpuBufferInfo {.cdecl, importc:"sg_wgpu_query_buffer_info".}
proc wgpuQueryBufferInfo*(buf:Buffer):WgpuBufferInfo =
    c_wgpuQueryBufferInfo(buf)

proc c_wgpuQueryImageInfo(img:Image):WgpuImageInfo {.cdecl, importc:"sg_wgpu_query_image_info".}
proc wgpuQueryImageInfo*(img:Image):WgpuImageInfo =
    c_wgpuQueryImageInfo(img)

proc c_wgpuQuerySamplerInfo(smp:Sampler):WgpuSamplerInfo {.cdecl, importc:"sg_wgpu_query_sampler_info".}
proc wgpuQuerySamplerInfo*(smp:Sampler):WgpuSamplerInfo =
    c_wgpuQuerySamplerInfo(smp)

proc c_wgpuQueryShaderInfo(shd:Shader):WgpuShaderInfo {.cdecl, importc:"sg_wgpu_query_shader_info".}
proc wgpuQueryShaderInfo*(shd:Shader):WgpuShaderInfo =
    c_wgpuQueryShaderInfo(shd)

proc c_wgpuQueryPipelineInfo(pip:Pipeline):WgpuPipelineInfo {.cdecl, importc:"sg_wgpu_query_pipeline_info".}
proc wgpuQueryPipelineInfo*(pip:Pipeline):WgpuPipelineInfo =
    c_wgpuQueryPipelineInfo(pip)

proc c_wgpuQueryAttachmentsInfo(atts:Attachments):WgpuAttachmentsInfo {.cdecl, importc:"sg_wgpu_query_attachments_info".}
proc wgpuQueryAttachmentsInfo*(atts:Attachments):WgpuAttachmentsInfo =
    c_wgpuQueryAttachmentsInfo(atts)

proc c_glQueryBufferInfo(buf:Buffer):GlBufferInfo {.cdecl, importc:"sg_gl_query_buffer_info".}
proc glQueryBufferInfo*(buf:Buffer):GlBufferInfo =
    c_glQueryBufferInfo(buf)

proc c_glQueryImageInfo(img:Image):GlImageInfo {.cdecl, importc:"sg_gl_query_image_info".}
proc glQueryImageInfo*(img:Image):GlImageInfo =
    c_glQueryImageInfo(img)

proc c_glQuerySamplerInfo(smp:Sampler):GlSamplerInfo {.cdecl, importc:"sg_gl_query_sampler_info".}
proc glQuerySamplerInfo*(smp:Sampler):GlSamplerInfo =
    c_glQuerySamplerInfo(smp)

proc c_glQueryShaderInfo(shd:Shader):GlShaderInfo {.cdecl, importc:"sg_gl_query_shader_info".}
proc glQueryShaderInfo*(shd:Shader):GlShaderInfo =
    c_glQueryShaderInfo(shd)

proc c_glQueryAttachmentsInfo(atts:Attachments):GlAttachmentsInfo {.cdecl, importc:"sg_gl_query_attachments_info".}
proc glQueryAttachmentsInfo*(atts:Attachments):GlAttachmentsInfo =
    c_glQueryAttachmentsInfo(atts)

when defined emscripten:
  const gl*    = true
  const d3d11* = false
  const metal* = false
  const emscripten* = true
elif defined gl:
  const gl*    = true
  const d3d11* = false
  const metal* = false
  const emscripten* = false
elif defined windows:
  const gl*    = false
  const d3d11* = true
  const metal* = false
  const emscripten* = false
elif defined macosx:
  const gl*    = false
  const d3d11* = false
  const metal* = true
  const emscripten* = false
elif defined linux:
  const gl*    = true
  const d3d11* = false
  const metal* = false
  const emscripten* = false
else:
  error("unsupported platform")

when defined emscripten:
  {.passl:"-lGL -ldl".}
  {.passc:"-DSOKOL_GLES3".}
  {.passL: "-s USE_WEBGL2=1".}
elif defined windows:
  when not defined vcc:
    {.passl:"-lkernel32 -luser32 -lshell32 -lgdi32".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE".}
  else:
    {.passc:"-DSOKOL_D3D11".}
    when not defined vcc:
      {.passl:"-ld3d11 -ldxgi".}
elif defined macosx:
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE".}
    {.passl:"-framework OpenGL".}
  else:
    {.passc:"-DSOKOL_METAL".}
    {.passl:"-framework Metal -framework MetalKit".}
elif defined linux:
  {.passc:"-DSOKOL_GLCORE".}
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
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_gfx.c".}
