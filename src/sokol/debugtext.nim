## machine generated, do not edit

import gfx

type Context* = object
  id*:uint32

type Range* = object
  `pointer`*:pointer
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

converter to_Desc_fonts*[N:static[int]](items: array[N, FontDesc]): array[8, FontDesc] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sdtx_setup".}
proc setup*(desc:Desc):void =
    c_setup(unsafeAddr(desc))

proc c_shutdown():void {.cdecl, importc:"sdtx_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_fontKc853():FontDesc {.cdecl, importc:"sdtx_font_kc853".}
proc fontKc853*():FontDesc =
    c_fontKc853()

proc c_fontKc854():FontDesc {.cdecl, importc:"sdtx_font_kc854".}
proc fontKc854*():FontDesc =
    c_fontKc854()

proc c_fontZ1013():FontDesc {.cdecl, importc:"sdtx_font_z1013".}
proc fontZ1013*():FontDesc =
    c_fontZ1013()

proc c_fontCpc():FontDesc {.cdecl, importc:"sdtx_font_cpc".}
proc fontCpc*():FontDesc =
    c_fontCpc()

proc c_fontC64():FontDesc {.cdecl, importc:"sdtx_font_c64".}
proc fontC64*():FontDesc =
    c_fontC64()

proc c_fontOric():FontDesc {.cdecl, importc:"sdtx_font_oric".}
proc fontOric*():FontDesc =
    c_fontOric()

proc c_makeContext(desc:ptr ContextDesc):Context {.cdecl, importc:"sdtx_make_context".}
proc makeContext*(desc:ContextDesc):Context =
    c_makeContext(unsafeAddr(desc))

proc c_destroyContext(ctx:Context):void {.cdecl, importc:"sdtx_destroy_context".}
proc destroyContext*(ctx:Context):void =
    c_destroyContext(ctx)

proc c_setContext(ctx:Context):void {.cdecl, importc:"sdtx_set_context".}
proc setContext*(ctx:Context):void =
    c_setContext(ctx)

proc c_getContext():Context {.cdecl, importc:"sdtx_get_context".}
proc getContext*():Context =
    c_getContext()

proc c_defaultContext():Context {.cdecl, importc:"sdtx_default_context".}
proc defaultContext*():Context =
    c_defaultContext()

proc c_draw():void {.cdecl, importc:"sdtx_draw".}
proc draw*():void =
    c_draw()

proc c_font(font_index:cint):void {.cdecl, importc:"sdtx_font".}
proc font*(font_index:cint):void =
    c_font(font_index)

proc c_canvas(w:cfloat, h:cfloat):void {.cdecl, importc:"sdtx_canvas".}
proc canvas*(w:cfloat, h:cfloat):void =
    c_canvas(w, h)

proc c_origin(x:cfloat, y:cfloat):void {.cdecl, importc:"sdtx_origin".}
proc origin*(x:cfloat, y:cfloat):void =
    c_origin(x, y)

proc c_home():void {.cdecl, importc:"sdtx_home".}
proc home*():void =
    c_home()

proc c_pos(x:cfloat, y:cfloat):void {.cdecl, importc:"sdtx_pos".}
proc pos*(x:cfloat, y:cfloat):void =
    c_pos(x, y)

proc c_posX(x:cfloat):void {.cdecl, importc:"sdtx_pos_x".}
proc posX*(x:cfloat):void =
    c_posX(x)

proc c_posY(y:cfloat):void {.cdecl, importc:"sdtx_pos_y".}
proc posY*(y:cfloat):void =
    c_posY(y)

proc c_move(dx:cfloat, dy:cfloat):void {.cdecl, importc:"sdtx_move".}
proc move*(dx:cfloat, dy:cfloat):void =
    c_move(dx, dy)

proc c_moveX(dx:cfloat):void {.cdecl, importc:"sdtx_move_x".}
proc moveX*(dx:cfloat):void =
    c_moveX(dx)

proc c_moveY(dy:cfloat):void {.cdecl, importc:"sdtx_move_y".}
proc moveY*(dy:cfloat):void =
    c_moveY(dy)

proc c_crlf():void {.cdecl, importc:"sdtx_crlf".}
proc crlf*():void =
    c_crlf()

proc c_color3b(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sdtx_color3b".}
proc color3b*(r:uint8, g:uint8, b:uint8):void =
    c_color3b(r, g, b)

proc c_color3f(r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sdtx_color3f".}
proc color3f*(r:cfloat, g:cfloat, b:cfloat):void =
    c_color3f(r, g, b)

proc c_color4b(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sdtx_color4b".}
proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_color4b(r, g, b, a)

proc c_color4f(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sdtx_color4f".}
proc color4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_color4f(r, g, b, a)

proc c_color1i(rgba:uint32):void {.cdecl, importc:"sdtx_color1i".}
proc color1i*(rgba:uint32):void =
    c_color1i(rgba)

proc c_putc(c:cchar):void {.cdecl, importc:"sdtx_putc".}
proc putc*(c:cchar):void =
    c_putc(c)

proc c_puts(str:cstring):void {.cdecl, importc:"sdtx_puts".}
proc puts*(str:cstring):void =
    c_puts(str)

proc c_putr(str:cstring, len:cint):void {.cdecl, importc:"sdtx_putr".}
proc putr*(str:cstring, len:cint):void =
    c_putr(str, len)

# helper function to convert "anything" into a Range
converter to_Range*[T](source: T): Range =
  Range(pointer: source.unsafeAddr, size: source.sizeof.uint)

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_debugtext.c".}
