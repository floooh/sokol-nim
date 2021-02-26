## machine generated, do not edit

import gfx

type Context* = object
  id*:uint32

type Range* = object
  source*:pointer
  size*:int

type FontDesc* = object
  data*:Range
  firstChar*:uint8
  lastChar*:uint8

type ContextDesc* = object
  charBufSize*:int32
  canvasWidth*:float32
  canvasHeight*:float32
  tabWidth*:int32
  colorFormat*:sg.PixelFormat
  depthFormat*:sg.PixelFormat
  sampleCount*:int32

type Desc* = object
  contextPoolSize*:int32
  printfBufSize*:int32
  fonts*:array[8, FontDesc]
  context*:ContextDesc

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

proc draw*():void {.cdecl, importc:"sdtx_draw".}

proc font*(font_index:int32):void {.cdecl, importc:"sdtx_font".}

proc canvas*(w:float32, h:float32):void {.cdecl, importc:"sdtx_canvas".}

proc origin*(x:float32, y:float32):void {.cdecl, importc:"sdtx_origin".}

proc home*():void {.cdecl, importc:"sdtx_home".}

proc pos*(x:float32, y:float32):void {.cdecl, importc:"sdtx_pos".}

proc posX*(x:float32):void {.cdecl, importc:"sdtx_pos_x".}

proc posY*(y:float32):void {.cdecl, importc:"sdtx_pos_y".}

proc move*(dx:float32, dy:float32):void {.cdecl, importc:"sdtx_move".}

proc moveX*(dx:float32):void {.cdecl, importc:"sdtx_move_x".}

proc moveY*(dy:float32):void {.cdecl, importc:"sdtx_move_y".}

proc crlf*():void {.cdecl, importc:"sdtx_crlf".}

proc color3b*(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sdtx_color3b".}

proc color3f*(r:float32, g:float32, b:float32):void {.cdecl, importc:"sdtx_color3f".}

proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sdtx_color4b".}

proc color4f*(r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sdtx_color4f".}

proc color1i*(rgba:uint32):void {.cdecl, importc:"sdtx_color1i".}

proc putc*(c:char):void {.cdecl, importc:"sdtx_putc".}

proc puts*(str:cstring):void {.cdecl, importc:"sdtx_puts".}

proc putr*(str:cstring, len:int32):void {.cdecl, importc:"sdtx_putr".}

# Nim-specific API extensions
include ext/debugtext
