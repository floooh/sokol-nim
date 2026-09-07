## machine generated, do not edit
when defined(nimony):
  {.feature: "lenientconverters".}

when not defined(nimony):
  import std/macros
  macro requires(condition: untyped, body: untyped): untyped =
    result = body
    let assertStmt = quote do:
      static:
        doAssert `condition`, "Precondition failed: " + astToStr(`condition`)
    result.body.insert(0, assertStmt)
import gfx
import app

type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemBufferOverflow,

type Allocator* = object
  allocFn*:proc(a1:int, a2:nil pointer):nil pointer {.cdecl.}
  freeFn*:proc(a1:nil pointer, a2:nil pointer) {.cdecl.}
  userData*:nil pointer

type Logger* = object
  fn*:proc(a1:nil cstring, a2:uint32, a3:uint32, a4:nil cstring, a5:uint32, a6:nil cstring, a7:nil pointer) {.cdecl.}
  userData*:nil pointer

type Desc* = object
  maxVertices*:int32
  colorFormat*:gfx.PixelFormat
  depthFormat*:gfx.PixelFormat
  sampleCount*:int32
  iniFilename*:nil cstring
  noDefaultFont*:bool
  disablePasteOverride*:bool
  disableSetMouseCursor*:bool
  disableWindowsResizeFromEdges*:bool
  writeAlphaChannel*:bool
  allocator*:Allocator
  logger*:Logger

type FrameDesc* = object
  width*:int32
  height*:int32
  deltaTime*:float64
  dpiScale*:float32

type FontTexDesc* = object
  minFilter*:gfx.Filter
  magFilter*:gfx.Filter

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"simgui_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

proc c_newFrame(desc:ptr FrameDesc):void {.cdecl, importc:"simgui_new_frame".}
proc newFrame*(desc:FrameDesc):void =
    c_newFrame(addr(desc))

proc c_render():void {.cdecl, importc:"simgui_render".}
proc render*():void =
    c_render()

proc c_imtextureid(texView:gfx.View):uint64 {.cdecl, importc:"simgui_imtextureid".}
proc imtextureid*(texView:gfx.View):uint64 =
    c_imtextureid(texView)

proc c_imtextureidWithSampler(texView:gfx.View, smp:gfx.Sampler):uint64 {.cdecl, importc:"simgui_imtextureid_with_sampler".}
proc imtextureidWithSampler*(texView:gfx.View, smp:gfx.Sampler):uint64 =
    c_imtextureidWithSampler(texView, smp)

proc c_textureViewFromImtextureid(imtexId:uint64):gfx.View {.cdecl, importc:"simgui_texture_view_from_imtextureid".}
proc textureViewFromImtextureid*(imtexId:uint64):gfx.View =
    c_textureViewFromImtextureid(imtexId)

proc c_samplerFromImtextureid(imtexId:uint64):gfx.Sampler {.cdecl, importc:"simgui_sampler_from_imtextureid".}
proc samplerFromImtextureid*(imtexId:uint64):gfx.Sampler =
    c_samplerFromImtextureid(imtexId)

proc c_addFocusEvent(focus:bool):void {.cdecl, importc:"simgui_add_focus_event".}
proc addFocusEvent*(focus:bool):void =
    c_addFocusEvent(focus)

proc c_addMousePosEvent(x:float32, y:float32):void {.cdecl, importc:"simgui_add_mouse_pos_event".}
proc addMousePosEvent*(x:float32, y:float32):void =
    c_addMousePosEvent(x, y)

proc c_addTouchPosEvent(x:float32, y:float32):void {.cdecl, importc:"simgui_add_touch_pos_event".}
proc addTouchPosEvent*(x:float32, y:float32):void =
    c_addTouchPosEvent(x, y)

proc c_addMouseButtonEvent(mouseButton:int32, down:bool):void {.cdecl, importc:"simgui_add_mouse_button_event".}
proc addMouseButtonEvent*(mouseButton:int32, down:bool):void =
    c_addMouseButtonEvent(mouseButton, down)

proc c_addMouseWheelEvent(wheelX:float32, wheelY:float32):void {.cdecl, importc:"simgui_add_mouse_wheel_event".}
proc addMouseWheelEvent*(wheelX:float32, wheelY:float32):void =
    c_addMouseWheelEvent(wheelX, wheelY)

proc c_addKeyEvent(imguiKey:int32, down:bool):void {.cdecl, importc:"simgui_add_key_event".}
proc addKeyEvent*(imguiKey:int32, down:bool):void =
    c_addKeyEvent(imguiKey, down)

proc c_addInputCharacter(c:uint32):void {.cdecl, importc:"simgui_add_input_character".}
proc addInputCharacter*(c:uint32):void =
    c_addInputCharacter(c)

proc c_addInputCharactersUtf8(c:nil cstring):void {.cdecl, importc:"simgui_add_input_characters_utf8".}
proc addInputCharactersUtf8*(c:nil cstring):void =
    c_addInputCharactersUtf8(c)

proc c_addTouchButtonEvent(mouseButton:int32, down:bool):void {.cdecl, importc:"simgui_add_touch_button_event".}
proc addTouchButtonEvent*(mouseButton:int32, down:bool):void =
    c_addTouchButtonEvent(mouseButton, down)

proc c_handleEvent(ev:ptr app.Event):bool {.cdecl, importc:"simgui_handle_event".}
proc handleEvent*(ev:app.Event):bool =
    c_handleEvent(addr(ev))

proc c_mapKeycode(keycode:app.Keycode):int32 {.cdecl, importc:"simgui_map_keycode".}
proc mapKeycode*(keycode:app.Keycode):int32 =
    c_mapKeycode(keycode)

proc c_shutdown():void {.cdecl, importc:"simgui_shutdown".}
proc shutdown*():void =
    c_shutdown()

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
