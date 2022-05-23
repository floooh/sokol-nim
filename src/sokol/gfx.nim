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
  `ptr`*:pointer
  size*:csize_t

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
  r*:cfloat
  g*:cfloat
  b*:cfloat
  a*:cfloat

type
  Backend* {.pure, size:sizeof(cint).} = enum
    glcore33,
    gles2,
    gles3,
    d3d11,
    metalIos,
    metalMacos,
    metalSimulator,
    wgpu,
    dummy,

type
  PixelFormat* {.pure, size:sizeof(uint32).} = enum
    default,
    none,
    r8,
    r8sn,
    r8ui,
    r8si,
    r16,
    r16sn,
    r16ui,
    r16si,
    r16f,
    rg8,
    rg8sn,
    rg8ui,
    rg8si,
    r32ui,
    r32si,
    r32f,
    rg16,
    rg16sn,
    rg16ui,
    rg16si,
    rg16f,
    rgba8,
    rgba8sn,
    rgba8ui,
    rgba8si,
    bgra8,
    rgb10a2,
    rg11b10f,
    rg32ui,
    rg32si,
    rg32f,
    rgba16,
    rgba16sn,
    rgba16ui,
    rgba16si,
    rgba16f,
    rgba32ui,
    rgba32si,
    rgba32f,
    depth,
    depthStencil,
    bc1Rgba,
    bc2Rgba,
    bc3Rgba,
    bc4R,
    bc4Rsn,
    bc5Rg,
    bc5Rgsn,
    bc6hRgbf,
    bc6hRgbuf,
    bc7Rgba,
    pvrtcRgb2bpp,
    pvrtcRgb4bpp,
    pvrtcRgba2bpp,
    pvrtcRgba4bpp,
    etc2Rgb8,
    etc2Rgb8a1,
    etc2Rgba8,
    etc2Rg11,
    etc2Rg11sn,

type PixelformatInfo* = object
  sample*:bool
  filter*:bool
  render*:bool
  blend*:bool
  msaa*:bool
  depth*:bool

type Features* = object
  instancing*:bool
  originTopLeft*:bool
  multipleRenderTargets*:bool
  msaaRenderTargets*:bool
  imagetype3d*:bool
  imagetypeArray*:bool
  imageClampToBorder*:bool
  mrtIndependentBlendState*:bool
  mrtIndependentWriteMask*:bool

type Limits* = object
  maxImageSize2d*:cint
  maxImageSizeCube*:cint
  maxImageSize3d*:cint
  maxImageSizeArray*:cint
  maxImageArrayLayers*:cint
  maxVertexAttrs*:cint
  glMaxVertexUniformVectors*:cint

type
  ResourceState* {.pure, size:sizeof(uint32).} = enum
    initial,
    alloc,
    valid,
    failed,
    invalid,

type
  Usage* {.pure, size:sizeof(uint32).} = enum
    default,
    immutable,
    dynamic,
    stream,

type
  BufferType* {.pure, size:sizeof(uint32).} = enum
    default,
    vertexBuffer,
    indexBuffer,

type
  IndexType* {.pure, size:sizeof(uint32).} = enum
    default,
    none,
    `uint16`,
    `uint32`,

type
  ImageType* {.pure, size:sizeof(uint32).} = enum
    default,
    plane,
    cube,
    volume,
    array,

type
  SamplerType* {.pure, size:sizeof(cint).} = enum
    default,
    `float`,
    sint,
    `uint`,

type
  CubeFace* {.pure, size:sizeof(uint32).} = enum
    posX,
    negX,
    posY,
    negY,
    posZ,
    negZ,

type
  ShaderStage* {.pure, size:sizeof(uint32).} = enum
    vs,
    fs,

type
  PrimitiveType* {.pure, size:sizeof(uint32).} = enum
    default,
    points,
    lines,
    lineStrip,
    triangles,
    triangleStrip,

type
  Filter* {.pure, size:sizeof(uint32).} = enum
    default,
    nearest,
    linear,
    nearestMipmapNearest,
    nearestMipmapLinear,
    linearMipmapNearest,
    linearMipmapLinear,

type
  Wrap* {.pure, size:sizeof(uint32).} = enum
    default,
    repeat,
    clampToEdge,
    clampToBorder,
    mirroredRepeat,

type
  BorderColor* {.pure, size:sizeof(uint32).} = enum
    default,
    transparentBlack,
    opaqueBlack,
    opaqueWhite,

type
  VertexFormat* {.pure, size:sizeof(uint32).} = enum
    invalid,
    `float`,
    float2,
    float3,
    float4,
    byte4,
    byte4n,
    ubyte4,
    ubyte4n,
    short2,
    short2n,
    ushort2n,
    short4,
    short4n,
    ushort4n,
    uint10N2,

type
  VertexStep* {.pure, size:sizeof(uint32).} = enum
    default,
    perVertex,
    perInstance,

type
  UniformType* {.pure, size:sizeof(uint32).} = enum
    invalid,
    `float`,
    float2,
    float3,
    float4,
    `int`,
    int2,
    int3,
    int4,
    mat4,

type
  UniformLayout* {.pure, size:sizeof(uint32).} = enum
    default,
    native,
    std140,

type
  CullMode* {.pure, size:sizeof(uint32).} = enum
    default,
    none,
    front,
    back,

type
  FaceWinding* {.pure, size:sizeof(uint32).} = enum
    default,
    ccw,
    cw,

type
  CompareFunc* {.pure, size:sizeof(uint32).} = enum
    default,
    never,
    less,
    equal,
    lessEqual,
    greater,
    notEqual,
    greaterEqual,
    always,

type
  StencilOp* {.pure, size:sizeof(uint32).} = enum
    default,
    keep,
    zero,
    replace,
    incrClamp,
    decrClamp,
    invert,
    incrWrap,
    decrWrap,

type
  BlendFactor* {.pure, size:sizeof(uint32).} = enum
    default,
    zero,
    one,
    srcColor,
    oneMinusSrcColor,
    srcAlpha,
    oneMinusSrcAlpha,
    dstColor,
    oneMinusDstColor,
    dstAlpha,
    oneMinusDstAlpha,
    srcAlphaSaturated,
    blendColor,
    oneMinusBlendColor,
    blendAlpha,
    oneMinusBlendAlpha,

type
  BlendOp* {.pure, size:sizeof(uint32).} = enum
    default,
    add,
    subtract,
    reverseSubtract,

type
  ColorMask* {.pure, size:sizeof(uint32).} = enum
    default = 0,
    r = 1,
    g = 2,
    rg = 3,
    b = 4,
    rb = 5,
    gb = 6,
    rgb = 7,
    a = 8,
    ra = 9,
    ga = 10,
    rga = 11,
    ba = 12,
    rba = 13,
    gba = 14,
    rgba = 15,
    none = 16,

type
  Action* {.pure, size:sizeof(uint32).} = enum
    default,
    clear,
    load,
    dontCare,

type ColorAttachmentAction* = object
  action*:Action
  value*:Color

type DepthAttachmentAction* = object
  action*:Action
  value*:cfloat

type StencilAttachmentAction* = object
  action*:Action
  value*:uint8

type PassAction* = object
  startCanary:uint32
  colors*:array[4, ColorAttachmentAction]
  depth*:DepthAttachmentAction
  stencil*:StencilAttachmentAction
  endCanary:uint32

type Bindings* = object
  startCanary:uint32
  vertexBuffers*:array[8, Buffer]
  vertexBufferOffsets*:array[8, cint]
  indexBuffer*:Buffer
  indexBufferOffset*:cint
  vsImages*:array[12, Image]
  fsImages*:array[12, Image]
  endCanary:uint32

type BufferDesc* = object
  startCanary:uint32
  size*:csize_t
  `type`*:BufferType
  usage*:Usage
  data*:Range
  label*:cstring
  glBuffers*:array[2, uint32]
  mtlBuffers*:array[2, pointer]
  d3d11Buffer*:pointer
  wgpuBuffer*:pointer
  endCanary:uint32

type ImageData* = object
  subimage*:array[6, array[16, Range]]

type ImageDesc* = object
  startCanary:uint32
  `type`*:ImageType
  renderTarget*:bool
  width*:cint
  height*:cint
  numSlices*:cint
  numMipmaps*:cint
  usage*:Usage
  pixelFormat*:PixelFormat
  sampleCount*:cint
  minFilter*:Filter
  magFilter*:Filter
  wrapU*:Wrap
  wrapV*:Wrap
  wrapW*:Wrap
  borderColor*:BorderColor
  maxAnisotropy*:uint32
  minLod*:cfloat
  maxLod*:cfloat
  data*:ImageData
  label*:cstring
  glTextures*:array[2, uint32]
  glTextureTarget*:uint32
  mtlTextures*:array[2, pointer]
  d3d11Texture*:pointer
  d3d11ShaderResourceView*:pointer
  wgpuTexture*:pointer
  endCanary:uint32

type ShaderAttrDesc* = object
  name*:cstring
  semName*:cstring
  semIndex*:cint

type ShaderUniformDesc* = object
  name*:cstring
  `type`*:UniformType
  arrayCount*:cint

type ShaderUniformBlockDesc* = object
  size*:csize_t
  layout*:UniformLayout
  uniforms*:array[16, ShaderUniformDesc]

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

type ShaderDesc* = object
  startCanary:uint32
  attrs*:array[16, ShaderAttrDesc]
  vs*:ShaderStageDesc
  fs*:ShaderStageDesc
  label*:cstring
  endCanary:uint32

type BufferLayoutDesc* = object
  stride*:cint
  stepFunc*:VertexStep
  stepRate*:cint

type VertexAttrDesc* = object
  bufferIndex*:cint
  offset*:cint
  format*:VertexFormat

type LayoutDesc* = object
  buffers*:array[8, BufferLayoutDesc]
  attrs*:array[16, VertexAttrDesc]

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
  bias*:cfloat
  biasSlopeScale*:cfloat
  biasClamp*:cfloat

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
  colorCount*:cint
  colors*:array[4, ColorState]
  primitiveType*:PrimitiveType
  indexType*:IndexType
  cullMode*:CullMode
  faceWinding*:FaceWinding
  sampleCount*:cint
  blendColor*:Color
  alphaToCoverageEnabled*:bool
  label*:cstring
  endCanary:uint32

type PassAttachmentDesc* = object
  image*:Image
  mipLevel*:cint
  slice*:cint

type PassDesc* = object
  startCanary:uint32
  colorAttachments*:array[4, PassAttachmentDesc]
  depthStencilAttachment*:PassAttachmentDesc
  label*:cstring
  endCanary:uint32

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
  appendBuffer*:proc(a1:Buffer, a2:ptr Range, a3:cint, a4:pointer) {.cdecl.}
  beginDefaultPass*:proc(a1:ptr PassAction, a2:cint, a3:cint, a4:pointer) {.cdecl.}
  beginPass*:proc(a1:Pass, a2:ptr PassAction, a3:pointer) {.cdecl.}
  applyViewport*:proc(a1:cint, a2:cint, a3:cint, a4:cint, a5:bool, a6:pointer) {.cdecl.}
  applyScissorRect*:proc(a1:cint, a2:cint, a3:cint, a4:cint, a5:bool, a6:pointer) {.cdecl.}
  applyPipeline*:proc(a1:Pipeline, a2:pointer) {.cdecl.}
  applyBindings*:proc(a1:ptr Bindings, a2:pointer) {.cdecl.}
  applyUniforms*:proc(a1:ShaderStage, a2:cint, a3:ptr Range, a4:pointer) {.cdecl.}
  draw*:proc(a1:cint, a2:cint, a3:cint, a4:pointer) {.cdecl.}
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
  appendPos*:cint
  appendOverflow*:bool
  numSlots*:cint
  activeSlot*:cint

type ImageInfo* = object
  slot*:SlotInfo
  updFrameIndex*:uint32
  numSlots*:cint
  activeSlot*:cint
  width*:cint
  height*:cint

type ShaderInfo* = object
  slot*:SlotInfo

type PipelineInfo* = object
  slot*:SlotInfo

type PassInfo* = object
  slot*:SlotInfo

type GlContextDesc* = object
  forceGles2*:bool

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
  colorFormat*:PixelFormat
  depthFormat*:PixelFormat
  sampleCount*:cint
  gl*:GlContextDesc
  metal*:MetalContextDesc
  d3d11*:D3d11ContextDesc
  wgpu*:WgpuContextDesc

type Allocator* = object
  alloc*:proc(a1:csize_t, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  startCanary:uint32
  bufferPoolSize*:cint
  imagePoolSize*:cint
  shaderPoolSize*:cint
  pipelinePoolSize*:cint
  passPoolSize*:cint
  contextPoolSize*:cint
  uniformBufferSize*:cint
  stagingBufferSize*:cint
  samplerCacheSize*:cint
  allocator*:Allocator
  context*:ContextDesc
  endCanary:uint32

proc setup*(desc:ptr Desc):void {.cdecl, importc:"sg_setup".}

proc shutdown*():void {.cdecl, importc:"sg_shutdown".}

proc isvalid*():bool {.cdecl, importc:"sg_isvalid".}

proc resetStateCache*():void {.cdecl, importc:"sg_reset_state_cache".}

proc installTraceHooks*(trace_hooks:ptr TraceHooks):TraceHooks {.cdecl, importc:"sg_install_trace_hooks".}

proc pushDebugGroup*(name:cstring):void {.cdecl, importc:"sg_push_debug_group".}

proc popDebugGroup*():void {.cdecl, importc:"sg_pop_debug_group".}

proc makeBuffer*(desc:ptr BufferDesc):Buffer {.cdecl, importc:"sg_make_buffer".}

proc makeImage*(desc:ptr ImageDesc):Image {.cdecl, importc:"sg_make_image".}

proc makeShader*(desc:ptr ShaderDesc):Shader {.cdecl, importc:"sg_make_shader".}

proc makePipeline*(desc:ptr PipelineDesc):Pipeline {.cdecl, importc:"sg_make_pipeline".}

proc makePass*(desc:ptr PassDesc):Pass {.cdecl, importc:"sg_make_pass".}

proc destroyBuffer*(buf:Buffer):void {.cdecl, importc:"sg_destroy_buffer".}

proc destroyImage*(img:Image):void {.cdecl, importc:"sg_destroy_image".}

proc destroyShader*(shd:Shader):void {.cdecl, importc:"sg_destroy_shader".}

proc destroyPipeline*(pip:Pipeline):void {.cdecl, importc:"sg_destroy_pipeline".}

proc destroyPass*(pass:Pass):void {.cdecl, importc:"sg_destroy_pass".}

proc updateBuffer*(buf:Buffer, data:ptr Range):void {.cdecl, importc:"sg_update_buffer".}

proc updateImage*(img:Image, data:ptr ImageData):void {.cdecl, importc:"sg_update_image".}

proc appendBuffer*(buf:Buffer, data:ptr Range):cint {.cdecl, importc:"sg_append_buffer".}

proc queryBufferOverflow*(buf:Buffer):bool {.cdecl, importc:"sg_query_buffer_overflow".}

proc beginDefaultPass*(pass_action:ptr PassAction, width:cint, height:cint):void {.cdecl, importc:"sg_begin_default_pass".}

proc beginDefaultPassf*(pass_action:ptr PassAction, width:cfloat, height:cfloat):void {.cdecl, importc:"sg_begin_default_passf".}

proc beginPass*(pass:Pass, pass_action:ptr PassAction):void {.cdecl, importc:"sg_begin_pass".}

proc applyViewport*(x:cint, y:cint, width:cint, height:cint, origin_top_left:bool):void {.cdecl, importc:"sg_apply_viewport".}

proc applyViewportf*(x:cfloat, y:cfloat, width:cfloat, height:cfloat, origin_top_left:bool):void {.cdecl, importc:"sg_apply_viewportf".}

proc applyScissorRect*(x:cint, y:cint, width:cint, height:cint, origin_top_left:bool):void {.cdecl, importc:"sg_apply_scissor_rect".}

proc applyScissorRectf*(x:cfloat, y:cfloat, width:cfloat, height:cfloat, origin_top_left:bool):void {.cdecl, importc:"sg_apply_scissor_rectf".}

proc applyPipeline*(pip:Pipeline):void {.cdecl, importc:"sg_apply_pipeline".}

proc applyBindings*(bindings:ptr Bindings):void {.cdecl, importc:"sg_apply_bindings".}

proc applyUniforms*(stage:ShaderStage, ub_index:cint, data:ptr Range):void {.cdecl, importc:"sg_apply_uniforms".}

proc draw*(base_element:cint, num_elements:cint, num_instances:cint):void {.cdecl, importc:"sg_draw".}

proc endPass*():void {.cdecl, importc:"sg_end_pass".}

proc commit*():void {.cdecl, importc:"sg_commit".}

proc queryDesc*():Desc {.cdecl, importc:"sg_query_desc".}

proc queryBackend*():Backend {.cdecl, importc:"sg_query_backend".}

proc queryFeatures*():Features {.cdecl, importc:"sg_query_features".}

proc queryLimits*():Limits {.cdecl, importc:"sg_query_limits".}

proc queryPixelformat*(fmt:PixelFormat):PixelformatInfo {.cdecl, importc:"sg_query_pixelformat".}

proc queryBufferState*(buf:Buffer):ResourceState {.cdecl, importc:"sg_query_buffer_state".}

proc queryImageState*(img:Image):ResourceState {.cdecl, importc:"sg_query_image_state".}

proc queryShaderState*(shd:Shader):ResourceState {.cdecl, importc:"sg_query_shader_state".}

proc queryPipelineState*(pip:Pipeline):ResourceState {.cdecl, importc:"sg_query_pipeline_state".}

proc queryPassState*(pass:Pass):ResourceState {.cdecl, importc:"sg_query_pass_state".}

proc queryBufferInfo*(buf:Buffer):BufferInfo {.cdecl, importc:"sg_query_buffer_info".}

proc queryImageInfo*(img:Image):ImageInfo {.cdecl, importc:"sg_query_image_info".}

proc queryShaderInfo*(shd:Shader):ShaderInfo {.cdecl, importc:"sg_query_shader_info".}

proc queryPipelineInfo*(pip:Pipeline):PipelineInfo {.cdecl, importc:"sg_query_pipeline_info".}

proc queryPassInfo*(pass:Pass):PassInfo {.cdecl, importc:"sg_query_pass_info".}

proc queryBufferDefaults*(desc:ptr BufferDesc):BufferDesc {.cdecl, importc:"sg_query_buffer_defaults".}

proc queryImageDefaults*(desc:ptr ImageDesc):ImageDesc {.cdecl, importc:"sg_query_image_defaults".}

proc queryShaderDefaults*(desc:ptr ShaderDesc):ShaderDesc {.cdecl, importc:"sg_query_shader_defaults".}

proc queryPipelineDefaults*(desc:ptr PipelineDesc):PipelineDesc {.cdecl, importc:"sg_query_pipeline_defaults".}

proc queryPassDefaults*(desc:ptr PassDesc):PassDesc {.cdecl, importc:"sg_query_pass_defaults".}

proc allocBuffer*():Buffer {.cdecl, importc:"sg_alloc_buffer".}

proc allocImage*():Image {.cdecl, importc:"sg_alloc_image".}

proc allocShader*():Shader {.cdecl, importc:"sg_alloc_shader".}

proc allocPipeline*():Pipeline {.cdecl, importc:"sg_alloc_pipeline".}

proc allocPass*():Pass {.cdecl, importc:"sg_alloc_pass".}

proc deallocBuffer*(buf_id:Buffer):void {.cdecl, importc:"sg_dealloc_buffer".}

proc deallocImage*(img_id:Image):void {.cdecl, importc:"sg_dealloc_image".}

proc deallocShader*(shd_id:Shader):void {.cdecl, importc:"sg_dealloc_shader".}

proc deallocPipeline*(pip_id:Pipeline):void {.cdecl, importc:"sg_dealloc_pipeline".}

proc deallocPass*(pass_id:Pass):void {.cdecl, importc:"sg_dealloc_pass".}

proc initBuffer*(buf_id:Buffer, desc:ptr BufferDesc):void {.cdecl, importc:"sg_init_buffer".}

proc initImage*(img_id:Image, desc:ptr ImageDesc):void {.cdecl, importc:"sg_init_image".}

proc initShader*(shd_id:Shader, desc:ptr ShaderDesc):void {.cdecl, importc:"sg_init_shader".}

proc initPipeline*(pip_id:Pipeline, desc:ptr PipelineDesc):void {.cdecl, importc:"sg_init_pipeline".}

proc initPass*(pass_id:Pass, desc:ptr PassDesc):void {.cdecl, importc:"sg_init_pass".}

proc uninitBuffer*(buf_id:Buffer):bool {.cdecl, importc:"sg_uninit_buffer".}

proc uninitImage*(img_id:Image):bool {.cdecl, importc:"sg_uninit_image".}

proc uninitShader*(shd_id:Shader):bool {.cdecl, importc:"sg_uninit_shader".}

proc uninitPipeline*(pip_id:Pipeline):bool {.cdecl, importc:"sg_uninit_pipeline".}

proc uninitPass*(pass_id:Pass):bool {.cdecl, importc:"sg_uninit_pass".}

proc failBuffer*(buf_id:Buffer):void {.cdecl, importc:"sg_fail_buffer".}

proc failImage*(img_id:Image):void {.cdecl, importc:"sg_fail_image".}

proc failShader*(shd_id:Shader):void {.cdecl, importc:"sg_fail_shader".}

proc failPipeline*(pip_id:Pipeline):void {.cdecl, importc:"sg_fail_pipeline".}

proc failPass*(pass_id:Pass):void {.cdecl, importc:"sg_fail_pass".}

proc setupContext*():Context {.cdecl, importc:"sg_setup_context".}

proc activateContext*(ctx_id:Context):void {.cdecl, importc:"sg_activate_context".}

proc discardContext*(ctx_id:Context):void {.cdecl, importc:"sg_discard_context".}

proc d3d11Device*():pointer {.cdecl, importc:"sg_d3d11_device".}

proc mtlDevice*():pointer {.cdecl, importc:"sg_mtl_device".}

proc mtlRenderCommandEncoder*():pointer {.cdecl, importc:"sg_mtl_render_command_encoder".}

# Nim-specific API extensions
include extra/gfx
