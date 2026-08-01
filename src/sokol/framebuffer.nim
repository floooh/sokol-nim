## machine generated, do not edit

import gfx

const
  invalidId* = 0

type Framebuffer* = object
  id*:uint32

type
  ResourceState* {.size:sizeof(int32).} = enum
    resourceStateInitial,
    resourceStateAlloc,
    resourceStateValid,
    resourceStateFailed,
    resourceStateInvalid,

type
  Format* {.size:sizeof(int32).} = enum
    formatDefault = 0,
    formatRgba8 = 1,
    formatPalette8 = 2,

type Rect* = object
  x*:int32
  y*:int32
  width*:int32
  height*:int32

type RenderPassDesc* = object
  colorFormat*:gfx.PixelFormat
  depthFormat*:gfx.PixelFormat
  sampleCount*:int32

type FramebufferDesc* = object
  width*:int32
  height*:int32
  prescale*:int32
  format*:Format
  cliprect*:Rect
  rotate90*:bool
  renderPass*:RenderPassDesc

type ResizeDesc* = object
  width*:int32
  height*:int32
  prescale*:int32
  cliprect*:Rect

type UpdateDesc* = object
  pixels*:gfx.Range
  palette*:gfx.Range

type RenderDesc* = object
  useNearestFilter*:bool
  pip*:gfx.Pipeline
  views*:array[32, gfx.View]
  samplers*:array[12, gfx.Sampler]
  uniforms*:array[8, gfx.Range]

converter toRenderDescviews*[N:static[int]](items: array[N, gfx.View]): array[32, gfx.View] =
  static: assert(N <= 32)
  for index,item in items.pairs: result[index]=item

converter toRenderDescsamplers*[N:static[int]](items: array[N, gfx.Sampler]): array[12, gfx.Sampler] =
  static: assert(N <= 12)
  for index,item in items.pairs: result[index]=item

converter toRenderDescuniforms*[N:static[int]](items: array[N, gfx.Range]): array[8, gfx.Range] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

type TextureInfo* = object
  width*:int32
  height*:int32
  pixelFormat*:gfx.PixelFormat
  image*:gfx.Image
  texView*:gfx.View

type FramebufferInfo* = object
  update*:TextureInfo
  offscreen*:TextureInfo
  palette*:TextureInfo
  nearestSampler*:gfx.Sampler
  linearSampler*:gfx.Sampler

type Allocator* = object
  allocFn*:proc(a1:int, a2:pointer):pointer {.cdecl.}
  freeFn*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Logger* = object
  fn*:proc(a1:cstring, a2:uint32, a3:uint32, a4:cstring, a5:uint32, a6:cstring, a7:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  framebufferPoolSize*:int32
  allocator*:Allocator
  logger*:Logger

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sfb_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

proc c_shutdown():void {.cdecl, importc:"sfb_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_makeFramebuffer(desc:ptr FramebufferDesc):Framebuffer {.cdecl, importc:"sfb_make_framebuffer".}
proc makeFramebuffer*(desc:FramebufferDesc):Framebuffer =
    c_makeFramebuffer(addr(desc))

proc c_destroyFramebuffer(fb:Framebuffer):void {.cdecl, importc:"sfb_destroy_framebuffer".}
proc destroyFramebuffer*(fb:Framebuffer):void =
    c_destroyFramebuffer(fb)

proc c_resize(fb:Framebuffer, desc:ptr ResizeDesc):bool {.cdecl, importc:"sfb_resize".}
proc resize*(fb:Framebuffer, desc:ResizeDesc):bool =
    c_resize(fb, addr(desc))

proc c_update(fb:Framebuffer, desc:ptr UpdateDesc):void {.cdecl, importc:"sfb_update".}
proc update*(fb:Framebuffer, desc:UpdateDesc):void =
    c_update(fb, addr(desc))

proc c_render(fb:Framebuffer):void {.cdecl, importc:"sfb_render".}
proc render*(fb:Framebuffer):void =
    c_render(fb)

proc c_renderEx(fb:Framebuffer, desc:ptr RenderDesc):void {.cdecl, importc:"sfb_render_ex".}
proc renderEx*(fb:Framebuffer, desc:RenderDesc):void =
    c_renderEx(fb, addr(desc))

proc c_queryFramebufferState(fb:Framebuffer):ResourceState {.cdecl, importc:"sfb_query_framebuffer_state".}
proc queryFramebufferState*(fb:Framebuffer):ResourceState =
    c_queryFramebufferState(fb)

proc c_queryFramebufferInfo(fb:Framebuffer):FramebufferInfo {.cdecl, importc:"sfb_query_framebuffer_info".}
proc queryFramebufferInfo*(fb:Framebuffer):FramebufferInfo =
    c_queryFramebufferInfo(fb)

proc c_queryFramebufferDesc(fb:Framebuffer):FramebufferDesc {.cdecl, importc:"sfb_query_framebuffer_desc".}
proc queryFramebufferDesc*(fb:Framebuffer):FramebufferDesc =
    c_queryFramebufferDesc(fb)

{.passc:"-DIMPL".}
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_framebuffer.c".}
