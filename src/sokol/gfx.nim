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
  source*:pointer
  size*:int

const
  INVALID_ID* = 0
  NUM_SHADER_STAGES* = 2
  NUM_INFLIGHT_FRAMES* = 2
  MAX_COLOR_ATTACHMENTS* = 4
  MAX_SHADERSTAGE_BUFFERS* = 8
  MAX_SHADERSTAGE_IMAGES* = 12
  MAX_SHADERSTAGE_UBS* = 4
  MAX_UB_MEMBERS* = 16
  MAX_VERTEX_ATTRIBUTES* = 16
  MAX_MIPMAPS* = 16
  MAX_TEXTUREARRAY_LAYERS* = 128

type Color* = object
  r*:float32
  g*:float32
  b*:float32
  a*:float32

type Backend* {.pure.} = enum
  Glcore33,
  Gles2,
  Gles3,
  D3d11,
  MetalIos,
  MetalMacos,
  MetalSimulator,
  Wgpu,
  Dummy,

type PixelFormat* {.pure, size:4.} = enum
  Default,
  None,
  R8,
  R8sn,
  R8ui,
  R8si,
  R16,
  R16sn,
  R16ui,
  R16si,
  R16f,
  Rg8,
  Rg8sn,
  Rg8ui,
  Rg8si,
  R32ui,
  R32si,
  R32f,
  Rg16,
  Rg16sn,
  Rg16ui,
  Rg16si,
  Rg16f,
  Rgba8,
  Rgba8sn,
  Rgba8ui,
  Rgba8si,
  Bgra8,
  Rgb10a2,
  Rg11b10f,
  Rg32ui,
  Rg32si,
  Rg32f,
  Rgba16,
  Rgba16sn,
  Rgba16ui,
  Rgba16si,
  Rgba16f,
  Rgba32ui,
  Rgba32si,
  Rgba32f,
  Depth,
  DepthStencil,
  Bc1Rgba,
  Bc2Rgba,
  Bc3Rgba,
  Bc4R,
  Bc4Rsn,
  Bc5Rg,
  Bc5Rgsn,
  Bc6hRgbf,
  Bc6hRgbuf,
  Bc7Rgba,
  PvrtcRgb2bpp,
  PvrtcRgb4bpp,
  PvrtcRgba2bpp,
  PvrtcRgba4bpp,
  Etc2Rgb8,
  Etc2Rgb8a1,
  Etc2Rgba8,
  Etc2Rg11,
  Etc2Rg11sn,
  Num,

type PixelFormatInfo* = object
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
  maxImageSize2d*:int32
  maxImageSizeCube*:int32
  maxImageSize3d*:int32
  maxImageSizeArray*:int32
  maxImageArrayLayers*:int32
  maxVertexAttrs*:int32

type ResourceState* {.pure, size:4.} = enum
  Initial,
  Alloc,
  Valid,
  Failed,
  Invalid,

type Usage* {.pure, size:4.} = enum
  Default,
  Immutable,
  Dynamic,
  Stream,
  Num,

type BufferType* {.pure, size:4.} = enum
  Default,
  VertexBuffer,
  IndexBuffer,
  Num,

type IndexType* {.pure, size:4.} = enum
  Default,
  None,
  Uint16,
  Uint32,
  Num,

type ImageType* {.pure, size:4.} = enum
  Default,
  Plane,
  Cube,
  Volume,
  Array,
  Num,

type SamplerType* {.pure.} = enum
  Default,
  Float,
  Sint,
  Uint,

type CubeFace* {.pure, size:4.} = enum
  PosX,
  NegX,
  PosY,
  NegY,
  PosZ,
  NegZ,
  Num,

type ShaderStage* {.pure, size:4.} = enum
  Vertex,
  Fragment,

type PrimitiveType* {.pure, size:4.} = enum
  Default,
  Points,
  Lines,
  LineStrip,
  Triangles,
  TriangleStrip,
  Num,

type Filter* {.pure, size:4.} = enum
  Default,
  Nearest,
  Linear,
  NearestMipmapNearest,
  NearestMipmapLinear,
  LinearMipmapNearest,
  LinearMipmapLinear,
  Num,

type Wrap* {.pure, size:4.} = enum
  Default,
  Repeat,
  ClampToEdge,
  ClampToBorder,
  MirroredRepeat,
  Num,

type BorderColor* {.pure, size:4.} = enum
  Default,
  TransparentBlack,
  OpaqueBlack,
  OpaqueWhite,
  Num,

type VertexFormat* {.pure, size:4.} = enum
  Invalid,
  Float,
  Float2,
  Float3,
  Float4,
  Byte4,
  Byte4n,
  Ubyte4,
  Ubyte4n,
  Short2,
  Short2n,
  Ushort2n,
  Short4,
  Short4n,
  Ushort4n,
  Uint10N2,
  Num,

type VertexStep* {.pure, size:4.} = enum
  Default,
  PerVertex,
  PerInstance,
  Num,

type UniformType* {.pure, size:4.} = enum
  Invalid,
  Float,
  Float2,
  Float3,
  Float4,
  Mat4,
  Num,

type CullMode* {.pure, size:4.} = enum
  Default,
  None,
  Front,
  Back,
  Num,

type FaceWinding* {.pure, size:4.} = enum
  Default,
  Ccw,
  Cw,
  Num,

type CompareFunc* {.pure, size:4.} = enum
  Default,
  Never,
  Less,
  Equal,
  LessEqual,
  Greater,
  NotEqual,
  GreaterEqual,
  Always,
  Num,

type StencilOp* {.pure, size:4.} = enum
  Default,
  Keep,
  Zero,
  Replace,
  IncrClamp,
  DecrClamp,
  Invert,
  IncrWrap,
  DecrWrap,
  Num,

type BlendFactor* {.pure, size:4.} = enum
  Default,
  Zero,
  One,
  SrcColor,
  OneMinusSrcColor,
  SrcAlpha,
  OneMinusSrcAlpha,
  DstColor,
  OneMinusDstColor,
  DstAlpha,
  OneMinusDstAlpha,
  SrcAlphaSaturated,
  BlendColor,
  OneMinusBlendColor,
  BlendAlpha,
  OneMinusBlendAlpha,
  Num,

type BlendOp* {.pure, size:4.} = enum
  Default,
  Add,
  Subtract,
  ReverseSubtract,
  Num,

type ColorMask* {.pure, size:4.} = enum
  Default = 0,
  R = 1,
  G = 2,
  Rg = 3,
  B = 4,
  Rb = 5,
  Gb = 6,
  Rgb = 7,
  A = 8,
  Ra = 9,
  Ga = 10,
  Rga = 11,
  Ba = 12,
  Rba = 13,
  Gba = 14,
  Rgba = 15,
  None = 16,

type Action* {.pure, size:4.} = enum
  Default,
  Clear,
  Load,
  DontCare,
  Num,

type ColorAttachmentAction* = object
  action*:Action
  value*:Color

type DepthAttachmentAction* = object
  action*:Action
  value*:float32

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
  vertexBufferOffsets*:array[8, int32]
  indexBuffer*:Buffer
  indexBufferOffset*:int32
  vsImages*:array[12, Image]
  fsImages*:array[12, Image]
  endCanary:uint32

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

type ImageData* = object
  subimage*:array[6, array[16, Range]]

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

type PassAttachmentDesc* = object
  image*:Image
  mipLevel*:int32
  slice*:int32

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
  width*:int32
  height*:int32

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
  sampleCount*:int32
  gl*:GlContextDesc
  metal*:MetalContextDesc
  d3d11*:D3d11ContextDesc
  wgpu*:WgpuContextDesc

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

proc appendBuffer*(buf:Buffer, data:ptr Range):int32 {.cdecl, importc:"sg_append_buffer".}

proc queryBufferOverflow*(buf:Buffer):bool {.cdecl, importc:"sg_query_buffer_overflow".}

proc beginDefaultPass*(pass_action:ptr PassAction, width:int32, height:int32):void {.cdecl, importc:"sg_begin_default_pass".}

proc beginDefaultPassf*(pass_action:ptr PassAction, width:float32, height:float32):void {.cdecl, importc:"sg_begin_default_passf".}

proc beginPass*(pass:Pass, pass_action:ptr PassAction):void {.cdecl, importc:"sg_begin_pass".}

proc applyViewport*(x:int32, y:int32, width:int32, height:int32, origin_top_left:bool):void {.cdecl, importc:"sg_apply_viewport".}

proc applyViewportf*(x:float32, y:float32, width:float32, height:float32, origin_top_left:bool):void {.cdecl, importc:"sg_apply_viewportf".}

proc applyScissorRect*(x:int32, y:int32, width:int32, height:int32, origin_top_left:bool):void {.cdecl, importc:"sg_apply_scissor_rect".}

proc applyScissorRectf*(x:float32, y:float32, width:float32, height:float32, origin_top_left:bool):void {.cdecl, importc:"sg_apply_scissor_rectf".}

proc applyPipeline*(pip:Pipeline):void {.cdecl, importc:"sg_apply_pipeline".}

proc applyBindings*(bindings:ptr Bindings):void {.cdecl, importc:"sg_apply_bindings".}

proc applyUniforms*(stage:ShaderStage, ub_index:int32, data:ptr Range):void {.cdecl, importc:"sg_apply_uniforms".}

proc draw*(base_element:int32, num_elements:int32, num_instances:int32):void {.cdecl, importc:"sg_draw".}

proc endPass*():void {.cdecl, importc:"sg_end_pass".}

proc commit*():void {.cdecl, importc:"sg_commit".}

proc queryDesc*():Desc {.cdecl, importc:"sg_query_desc".}

proc queryBackend*():Backend {.cdecl, importc:"sg_query_backend".}

proc queryFeatures*():Features {.cdecl, importc:"sg_query_features".}

proc queryLimits*():Limits {.cdecl, importc:"sg_query_limits".}

proc queryPixelformat*(fmt:PixelFormat):PixelFormatInfo {.cdecl, importc:"sg_query_pixelformat".}

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
include ext/gfx
