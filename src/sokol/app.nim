## machine generated, do not edit

const
  MAX_TOUCHPOINTS* = 8
  MAX_MOUSEBUTTONS* = 3
  MAX_KEYCODES* = 512

type EventType* {.pure, size:4.} = enum
  Invalid,
  KeyDown,
  KeyUp,
  Char,
  MouseDown,
  MouseUp,
  MouseScroll,
  MouseMove,
  MouseEnter,
  MouseLeave,
  TouchesBegan,
  TouchesMoved,
  TouchesEnded,
  TouchesCancelled,
  Resized,
  Iconified,
  Restored,
  Suspended,
  Resumed,
  UpdateCursor,
  QuitRequested,
  ClipboardPasted,
  FilesDropped,
  Num,

type Keycode* {.pure.} = enum
  Invalid = 0,
  Space = 32,
  Apostrophe = 39,
  Comma = 44,
  Minus = 45,
  Period = 46,
  Slash = 47,
  N0 = 48,
  N1 = 49,
  N2 = 50,
  N3 = 51,
  N4 = 52,
  N5 = 53,
  N6 = 54,
  N7 = 55,
  N8 = 56,
  N9 = 57,
  Semicolon = 59,
  Equal = 61,
  A = 65,
  B = 66,
  C = 67,
  D = 68,
  E = 69,
  F = 70,
  G = 71,
  H = 72,
  I = 73,
  J = 74,
  K = 75,
  L = 76,
  M = 77,
  N = 78,
  O = 79,
  P = 80,
  Q = 81,
  R = 82,
  S = 83,
  T = 84,
  U = 85,
  V = 86,
  W = 87,
  X = 88,
  Y = 89,
  Z = 90,
  LeftBracket = 91,
  Backslash = 92,
  RightBracket = 93,
  GraveAccent = 96,
  World1 = 161,
  World2 = 162,
  Escape = 256,
  Enter = 257,
  Tab = 258,
  Backspace = 259,
  Insert = 260,
  Delete = 261,
  Right = 262,
  Left = 263,
  Down = 264,
  Up = 265,
  PageUp = 266,
  PageDown = 267,
  Home = 268,
  End = 269,
  CapsLock = 280,
  ScrollLock = 281,
  NumLock = 282,
  PrintScreen = 283,
  Pause = 284,
  F1 = 290,
  F2 = 291,
  F3 = 292,
  F4 = 293,
  F5 = 294,
  F6 = 295,
  F7 = 296,
  F8 = 297,
  F9 = 298,
  F10 = 299,
  F11 = 300,
  F12 = 301,
  F13 = 302,
  F14 = 303,
  F15 = 304,
  F16 = 305,
  F17 = 306,
  F18 = 307,
  F19 = 308,
  F20 = 309,
  F21 = 310,
  F22 = 311,
  F23 = 312,
  F24 = 313,
  F25 = 314,
  Kp0 = 320,
  Kp1 = 321,
  Kp2 = 322,
  Kp3 = 323,
  Kp4 = 324,
  Kp5 = 325,
  Kp6 = 326,
  Kp7 = 327,
  Kp8 = 328,
  Kp9 = 329,
  KpDecimal = 330,
  KpDivide = 331,
  KpMultiply = 332,
  KpSubtract = 333,
  KpAdd = 334,
  KpEnter = 335,
  KpEqual = 336,
  LeftShift = 340,
  LeftControl = 341,
  LeftAlt = 342,
  LeftSuper = 343,
  RightShift = 344,
  RightControl = 345,
  RightAlt = 346,
  RightSuper = 347,
  Menu = 348,

type Touchpoint* = object
  identifier*:uint
  posX*:float32
  posY*:float32
  changed*:bool

type Mousebutton* {.pure.} = enum
  Left = 0,
  Right = 1,
  Middle = 2,
  Invalid = 256,

const
  MODIFIER_SHIFT* = 1
  MODIFIER_CTRL* = 2
  MODIFIER_ALT* = 4
  MODIFIER_SUPER* = 8

type Event* = object
  frameCount*:uint64
  `type`*:EventType
  keyCode*:Keycode
  charCode*:uint32
  keyRepeat*:bool
  modifiers*:uint32
  mouseButton*:Mousebutton
  mouseX*:float32
  mouseY*:float32
  mouseDx*:float32
  mouseDy*:float32
  scrollX*:float32
  scrollY*:float32
  numTouches*:int32
  touches*:array[8, Touchpoint]
  windowWidth*:int32
  windowHeight*:int32
  framebufferWidth*:int32
  framebufferHeight*:int32

type Desc* = object
  initCb*:proc() {.cdecl.}
  frameCb*:proc() {.cdecl.}
  cleanupCb*:proc() {.cdecl.}
  eventCb*:proc(a1:ptr Event) {.cdecl.}
  failCb*:proc(a1:ptr uint8) {.cdecl.}
  userData*:pointer
  initUserdataCb*:proc(a1:pointer) {.cdecl.}
  frameUserdataCb*:proc(a1:pointer) {.cdecl.}
  cleanupUserdataCb*:proc(a1:pointer) {.cdecl.}
  eventUserdataCb*:proc(a1:ptr Event, a2:pointer) {.cdecl.}
  failUserdataCb*:proc(a1:ptr uint8, a2:pointer) {.cdecl.}
  width*:int32
  height*:int32
  sampleCount*:int32
  swapInterval*:int32
  highDpi*:bool
  fullscreen*:bool
  alpha*:bool
  windowTitle*:cstring
  userCursor*:bool
  enableClipboard*:bool
  clipboardSize*:int32
  enableDragndrop*:bool
  maxDroppedFiles*:int32
  maxDroppedFilePathLength*:int32
  glForceGles2*:bool
  win32ConsoleUtf8*:bool
  win32ConsoleCreate*:bool
  win32ConsoleAttach*:bool
  html5CanvasName*:cstring
  html5CanvasResize*:bool
  html5PreserveDrawingBuffer*:bool
  html5PremultipliedAlpha*:bool
  html5AskLeaveSite*:bool
  iosKeyboardResizesCanvas*:bool

type Html5FetchError* {.pure.} = enum
  FetchErrorNoError,
  FetchErrorBufferTooSmall,
  FetchErrorOther,

type Html5FetchResponse* = object
  succeeded*:bool
  errorCode*:Html5FetchError
  fileIndex*:int32
  fetchedSize*:uint32
  bufferPtr*:pointer
  bufferSize*:uint32
  userData*:pointer

type Html5FetchRequest* = object
  droppedFileIndex*:int32
  callback*:proc(a1:ptr Html5FetchResponse) {.cdecl.}
  bufferPtr*:pointer
  bufferSize*:uint32
  userData*:pointer

proc isvalid*():bool {.cdecl, importc:"sapp_isvalid".}

proc width*():int32 {.cdecl, importc:"sapp_width".}

proc widthf*():float32 {.cdecl, importc:"sapp_widthf".}

proc height*():int32 {.cdecl, importc:"sapp_height".}

proc heightf*():float32 {.cdecl, importc:"sapp_heightf".}

proc colorFormat*():int32 {.cdecl, importc:"sapp_color_format".}

proc depthFormat*():int32 {.cdecl, importc:"sapp_depth_format".}

proc sampleCount*():int32 {.cdecl, importc:"sapp_sample_count".}

proc highDpi*():bool {.cdecl, importc:"sapp_high_dpi".}

proc dpiScale*():float32 {.cdecl, importc:"sapp_dpi_scale".}

proc showKeyboard*(show:bool):void {.cdecl, importc:"sapp_show_keyboard".}

proc keyboardShown*():bool {.cdecl, importc:"sapp_keyboard_shown".}

proc isFullscreen*():bool {.cdecl, importc:"sapp_is_fullscreen".}

proc toggleFullscreen*():void {.cdecl, importc:"sapp_toggle_fullscreen".}

proc showMouse*(show:bool):void {.cdecl, importc:"sapp_show_mouse".}

proc mouseShown*():bool {.cdecl, importc:"sapp_mouse_shown".}

proc lockMouse*(lock:bool):void {.cdecl, importc:"sapp_lock_mouse".}

proc mouseLocked*():bool {.cdecl, importc:"sapp_mouse_locked".}

proc userdata*():pointer {.cdecl, importc:"sapp_userdata".}

proc queryDesc*():Desc {.cdecl, importc:"sapp_query_desc".}

proc requestQuit*():void {.cdecl, importc:"sapp_request_quit".}

proc cancelQuit*():void {.cdecl, importc:"sapp_cancel_quit".}

proc quit*():void {.cdecl, importc:"sapp_quit".}

proc consumeEvent*():void {.cdecl, importc:"sapp_consume_event".}

proc frameCount*():uint64 {.cdecl, importc:"sapp_frame_count".}

proc setClipboardString*(str:cstring):void {.cdecl, importc:"sapp_set_clipboard_string".}

proc getClipboardString*():cstring {.cdecl, importc:"sapp_get_clipboard_string".}

proc setWindowTitle*(str:cstring):void {.cdecl, importc:"sapp_set_window_title".}

proc getNumDroppedFiles*():int32 {.cdecl, importc:"sapp_get_num_dropped_files".}

proc getDroppedFilePath*(index:int32):cstring {.cdecl, importc:"sapp_get_dropped_file_path".}

proc run*(desc:ptr Desc):void {.cdecl, importc:"sapp_run".}

proc gles2*():bool {.cdecl, importc:"sapp_gles2".}

proc html5AskLeaveSite*(ask:bool):void {.cdecl, importc:"sapp_html5_ask_leave_site".}

proc html5GetDroppedFileSize*(index:int32):uint32 {.cdecl, importc:"sapp_html5_get_dropped_file_size".}

proc html5FetchDroppedFile*(request:ptr Html5FetchRequest):void {.cdecl, importc:"sapp_html5_fetch_dropped_file".}

proc metalGetDevice*():pointer {.cdecl, importc:"sapp_metal_get_device".}

proc metalGetRenderpassDescriptor*():pointer {.cdecl, importc:"sapp_metal_get_renderpass_descriptor".}

proc metalGetDrawable*():pointer {.cdecl, importc:"sapp_metal_get_drawable".}

proc macosGetWindow*():pointer {.cdecl, importc:"sapp_macos_get_window".}

proc iosGetWindow*():pointer {.cdecl, importc:"sapp_ios_get_window".}

proc d3d11GetDevice*():pointer {.cdecl, importc:"sapp_d3d11_get_device".}

proc d3d11GetDeviceContext*():pointer {.cdecl, importc:"sapp_d3d11_get_device_context".}

proc d3d11GetRenderTargetView*():pointer {.cdecl, importc:"sapp_d3d11_get_render_target_view".}

proc d3d11GetDepthStencilView*():pointer {.cdecl, importc:"sapp_d3d11_get_depth_stencil_view".}

proc win32GetHwnd*():pointer {.cdecl, importc:"sapp_win32_get_hwnd".}

proc wgpuGetDevice*():pointer {.cdecl, importc:"sapp_wgpu_get_device".}

proc wgpuGetRenderView*():pointer {.cdecl, importc:"sapp_wgpu_get_render_view".}

proc wgpuGetResolveView*():pointer {.cdecl, importc:"sapp_wgpu_get_resolve_view".}

proc wgpuGetDepthStencilView*():pointer {.cdecl, importc:"sapp_wgpu_get_depth_stencil_view".}

proc androidGetNativeActivity*():pointer {.cdecl, importc:"sapp_android_get_native_activity".}

# Nim-specific API extensions
include ext/app
