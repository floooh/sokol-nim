## machine generated, do not edit

import gfx

type Context* = object
  id*:uint32

type Range* = object
  `ptr`*:pointer
  size*:csize_t

type FontDesc* = object
  data*:Range
  firstChar*:uint8
  lastChar*:uint8

type ContextDesc* = object
  charBufSize*:cint
  canvasWidth*:cfloat
  canvasHeight*:cfloat
  tabWidth*:cint
  colorFormat*:gfx.PixelFormat
  depthFormat*:gfx.PixelFormat
  sampleCount*:cint

type Allocator* = object
  alloc*:proc(a1:csize_t, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  contextPoolSize*:cint
  printfBufSize*:cint
  fonts*:array[8, FontDesc]
  context*:ContextDesc
  allocator*:Allocator

proc setup*(desc:ptr Desc):void {.cdecl, importc:"sdtx_setup".}

proc shutdown*():void {.cdecl, importc:"sdtx_shutdown".}

proc fontKc853*():FontDesc {.cdecl, importc:"sdtx_font_kc853".}

proc fontKc854*():FontDesc {.cdecl, importc:"sdtx_font_kc854".}

proc fontZ1013*():FontDesc {.cdecl, importc:"sdtx_font_z1013".}

proc fontCpc*():FontDesc {.cdecl, importc:"sdtx_font_cpc".}

proc fontC64*():FontDesc {.cdecl, importc:"sdtx_font_c64".}

proc fontOric*():FontDesc {.cdecl, importc:"sdtx_font_oric".}

proc makeContext*(desc:ptr ContextDesc):Context {.cdecl, importc:"sdtx_make_context".}

proc destroyContext*(ctx:Context):void {.cdecl, importc:"sdtx_destroy_context".}

proc setContext*(ctx:Context):void {.cdecl, importc:"sdtx_set_context".}

proc getContext*():Context {.cdecl, importc:"sdtx_get_context".}

proc defaultContext*():Context {.cdecl, importc:"sdtx_default_context".}

proc draw*():void {.cdecl, importc:"sdtx_draw".}

proc font*(font_index:cint):void {.cdecl, importc:"sdtx_font".}

proc canvas*(w:cfloat, h:cfloat):void {.cdecl, importc:"sdtx_canvas".}

proc origin*(x:cfloat, y:cfloat):void {.cdecl, importc:"sdtx_origin".}

proc home*():void {.cdecl, importc:"sdtx_home".}

proc pos*(x:cfloat, y:cfloat):void {.cdecl, importc:"sdtx_pos".}

proc posX*(x:cfloat):void {.cdecl, importc:"sdtx_pos_x".}

proc posY*(y:cfloat):void {.cdecl, importc:"sdtx_pos_y".}

proc move*(dx:cfloat, dy:cfloat):void {.cdecl, importc:"sdtx_move".}

proc moveX*(dx:cfloat):void {.cdecl, importc:"sdtx_move_x".}

proc moveY*(dy:cfloat):void {.cdecl, importc:"sdtx_move_y".}

proc crlf*():void {.cdecl, importc:"sdtx_crlf".}

proc color3b*(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sdtx_color3b".}

proc color3f*(r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sdtx_color3f".}

proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sdtx_color4b".}

proc color4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sdtx_color4f".}

proc color1i*(rgba:uint32):void {.cdecl, importc:"sdtx_color1i".}

proc putc*(c:cchar):void {.cdecl, importc:"sdtx_putc".}

proc puts*(str:cstring):void {.cdecl, importc:"sdtx_puts".}

proc putr*(str:cstring, len:cint):void {.cdecl, importc:"sdtx_putr".}

# Nim-specific API extensions
include extra/debugtext
