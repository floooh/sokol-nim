## machine generated, do not edit

const
  maxTouchpoints* = 8
  maxMousebuttons* = 3
  maxKeycodes* = 512
  maxIconimages* = 8

type
  EventType* {.pure, size:sizeof(uint32).} = enum
    invalid,
    keyDown,
    keyUp,
    `char`,
    mouseDown,
    mouseUp,
    mouseScroll,
    mouseMove,
    mouseEnter,
    mouseLeave,
    touchesBegan,
    touchesMoved,
    touchesEnded,
    touchesCancelled,
    resized,
    iconified,
    restored,
    focused,
    unfocused,
    suspended,
    resumed,
    updateCursor,
    quitRequested,
    clipboardPasted,
    filesDropped,

type
  Keycode* {.pure, size:sizeof(cint).} = enum
    invalid = 0,
    space = 32,
    apostrophe = 39,
    comma = 44,
    minus = 45,
    period = 46,
    slash = 47,
    digit0 = 48,
    digit1 = 49,
    digit2 = 50,
    digit3 = 51,
    digit4 = 52,
    digit5 = 53,
    digit6 = 54,
    digit7 = 55,
    digit8 = 56,
    digit9 = 57,
    semicolon = 59,
    equal = 61,
    a = 65,
    b = 66,
    c = 67,
    d = 68,
    e = 69,
    f = 70,
    g = 71,
    h = 72,
    i = 73,
    j = 74,
    k = 75,
    l = 76,
    m = 77,
    n = 78,
    o = 79,
    p = 80,
    q = 81,
    r = 82,
    s = 83,
    t = 84,
    u = 85,
    v = 86,
    w = 87,
    x = 88,
    y = 89,
    z = 90,
    leftBracket = 91,
    backslash = 92,
    rightBracket = 93,
    graveAccent = 96,
    world1 = 161,
    world2 = 162,
    escape = 256,
    enter = 257,
    tab = 258,
    backspace = 259,
    insert = 260,
    delete = 261,
    right = 262,
    left = 263,
    down = 264,
    up = 265,
    pageUp = 266,
    pageDown = 267,
    home = 268,
    `end` = 269,
    capsLock = 280,
    scrollLock = 281,
    numLock = 282,
    printScreen = 283,
    pause = 284,
    f1 = 290,
    f2 = 291,
    f3 = 292,
    f4 = 293,
    f5 = 294,
    f6 = 295,
    f7 = 296,
    f8 = 297,
    f9 = 298,
    f10 = 299,
    f11 = 300,
    f12 = 301,
    f13 = 302,
    f14 = 303,
    f15 = 304,
    f16 = 305,
    f17 = 306,
    f18 = 307,
    f19 = 308,
    f20 = 309,
    f21 = 310,
    f22 = 311,
    f23 = 312,
    f24 = 313,
    f25 = 314,
    kp0 = 320,
    kp1 = 321,
    kp2 = 322,
    kp3 = 323,
    kp4 = 324,
    kp5 = 325,
    kp6 = 326,
    kp7 = 327,
    kp8 = 328,
    kp9 = 329,
    kpDecimal = 330,
    kpDivide = 331,
    kpMultiply = 332,
    kpSubtract = 333,
    kpAdd = 334,
    kpEnter = 335,
    kpEqual = 336,
    leftShift = 340,
    leftControl = 341,
    leftAlt = 342,
    leftSuper = 343,
    rightShift = 344,
    rightControl = 345,
    rightAlt = 346,
    rightSuper = 347,
    menu = 348,

type Touchpoint* = object
  identifier*:uint
  posX*:cfloat
  posY*:cfloat
  changed*:bool

type
  Mousebutton* {.pure, size:sizeof(cint).} = enum
    left = 0,
    right = 1,
    middle = 2,
    invalid = 256,

type
  EventModifier* {.pure, size:sizeof(cint).} = enum
    shift = 1,
    ctrl = 2,
    alt = 4,
    super = 8,
    lmb = 256,
    rmb = 512,
    mmb = 1024,
  EventModifiers = set[EventModifier]

type Event* = object
  frameCount*:uint64
  `type`*:EventType
  keyCode*:Keycode
  charCode*:uint32
  keyRepeat*:bool
  modifiers*:EventModifier
  mouseButton*:Mousebutton
  mouseX*:cfloat
  mouseY*:cfloat
  mouseDx*:cfloat
  mouseDy*:cfloat
  scrollX*:cfloat
  scrollY*:cfloat
  numTouches*:cint
  touches*:array[8, Touchpoint]
  windowWidth*:cint
  windowHeight*:cint
  framebufferWidth*:cint
  framebufferHeight*:cint

converter to_Event_touches*[N:static[int]](items: array[N, Touchpoint]): array[8, Touchpoint] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

type Range* = object
  `ptr`*:pointer
  size*:csize_t

type ImageDesc* = object
  width*:cint
  height*:cint
  pixels*:Range

type IconDesc* = object
  sokolDefault*:bool
  images*:array[8, ImageDesc]

converter to_IconDesc_images*[N:static[int]](items: array[N, ImageDesc]): array[8, ImageDesc] =
  static: assert(N < 8)
  for index,item in items.pairs: result[index]=item

type Allocator* = object
  alloc*:proc(a1:csize_t, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  initCb*:proc() {.cdecl.}
  frameCb*:proc() {.cdecl.}
  cleanupCb*:proc() {.cdecl.}
  eventCb*:proc(a1:ptr Event) {.cdecl.}
  failCb*:proc(a1:cstring) {.cdecl.}
  userData*:pointer
  initUserdataCb*:proc(a1:pointer) {.cdecl.}
  frameUserdataCb*:proc(a1:pointer) {.cdecl.}
  cleanupUserdataCb*:proc(a1:pointer) {.cdecl.}
  eventUserdataCb*:proc(a1:ptr Event, a2:pointer) {.cdecl.}
  failUserdataCb*:proc(a1:cstring, a2:pointer) {.cdecl.}
  width*:cint
  height*:cint
  sampleCount*:cint
  swapInterval*:cint
  highDpi*:bool
  fullscreen*:bool
  alpha*:bool
  windowTitle*:cstring
  userCursor*:bool
  enableClipboard*:bool
  clipboardSize*:cint
  enableDragndrop*:bool
  maxDroppedFiles*:cint
  maxDroppedFilePathLength*:cint
  icon*:IconDesc
  allocator*:Allocator
  glForceGles2*:bool
  glMajorVersion*:cint
  glMinorVersion*:cint
  win32ConsoleUtf8*:bool
  win32ConsoleCreate*:bool
  win32ConsoleAttach*:bool
  html5CanvasName*:cstring
  html5CanvasResize*:bool
  html5PreserveDrawingBuffer*:bool
  html5PremultipliedAlpha*:bool
  html5AskLeaveSite*:bool
  iosKeyboardResizesCanvas*:bool

type
  Html5FetchError* {.pure, size:sizeof(cint).} = enum
    fetchErrorNoError,
    fetchErrorBufferTooSmall,
    fetchErrorOther,

type Html5FetchResponse* = object
  succeeded*:bool
  errorCode*:Html5FetchError
  fileIndex*:cint
  fetchedSize*:uint32
  bufferPtr*:pointer
  bufferSize*:uint32
  userData*:pointer

type Html5FetchRequest* = object
  droppedFileIndex*:cint
  callback*:proc(a1:ptr Html5FetchResponse) {.cdecl.}
  bufferPtr*:pointer
  bufferSize*:uint32
  userData*:pointer

proc c_isvalid():bool {.cdecl, importc:"sapp_isvalid".}
proc isvalid*():bool =
    c_isvalid()

proc c_width():cint {.cdecl, importc:"sapp_width".}
proc width*():cint =
    c_width()

proc c_widthf():cfloat {.cdecl, importc:"sapp_widthf".}
proc widthf*():cfloat =
    c_widthf()

proc c_height():cint {.cdecl, importc:"sapp_height".}
proc height*():cint =
    c_height()

proc c_heightf():cfloat {.cdecl, importc:"sapp_heightf".}
proc heightf*():cfloat =
    c_heightf()

proc c_colorFormat():cint {.cdecl, importc:"sapp_color_format".}
proc colorFormat*():cint =
    c_colorFormat()

proc c_depthFormat():cint {.cdecl, importc:"sapp_depth_format".}
proc depthFormat*():cint =
    c_depthFormat()

proc c_sampleCount():cint {.cdecl, importc:"sapp_sample_count".}
proc sampleCount*():cint =
    c_sampleCount()

proc c_highDpi():bool {.cdecl, importc:"sapp_high_dpi".}
proc highDpi*():bool =
    c_highDpi()

proc c_dpiScale():cfloat {.cdecl, importc:"sapp_dpi_scale".}
proc dpiScale*():cfloat =
    c_dpiScale()

proc c_showKeyboard(show:bool):void {.cdecl, importc:"sapp_show_keyboard".}
proc showKeyboard*(show:bool):void =
    c_showKeyboard(show)

proc c_keyboardShown():bool {.cdecl, importc:"sapp_keyboard_shown".}
proc keyboardShown*():bool =
    c_keyboardShown()

proc c_isFullscreen():bool {.cdecl, importc:"sapp_is_fullscreen".}
proc isFullscreen*():bool =
    c_isFullscreen()

proc c_toggleFullscreen():void {.cdecl, importc:"sapp_toggle_fullscreen".}
proc toggleFullscreen*():void =
    c_toggleFullscreen()

proc c_showMouse(show:bool):void {.cdecl, importc:"sapp_show_mouse".}
proc showMouse*(show:bool):void =
    c_showMouse(show)

proc c_mouseShown():bool {.cdecl, importc:"sapp_mouse_shown".}
proc mouseShown*():bool =
    c_mouseShown()

proc c_lockMouse(lock:bool):void {.cdecl, importc:"sapp_lock_mouse".}
proc lockMouse*(lock:bool):void =
    c_lockMouse(lock)

proc c_mouseLocked():bool {.cdecl, importc:"sapp_mouse_locked".}
proc mouseLocked*():bool =
    c_mouseLocked()

proc c_userdata():pointer {.cdecl, importc:"sapp_userdata".}
proc userdata*():pointer =
    c_userdata()

proc c_queryDesc():Desc {.cdecl, importc:"sapp_query_desc".}
proc queryDesc*():Desc =
    c_queryDesc()

proc c_requestQuit():void {.cdecl, importc:"sapp_request_quit".}
proc requestQuit*():void =
    c_requestQuit()

proc c_cancelQuit():void {.cdecl, importc:"sapp_cancel_quit".}
proc cancelQuit*():void =
    c_cancelQuit()

proc c_quit():void {.cdecl, importc:"sapp_quit".}
proc quit*():void =
    c_quit()

proc c_consumeEvent():void {.cdecl, importc:"sapp_consume_event".}
proc consumeEvent*():void =
    c_consumeEvent()

proc c_frameCount():uint64 {.cdecl, importc:"sapp_frame_count".}
proc frameCount*():uint64 =
    c_frameCount()

proc c_frameDuration():cdouble {.cdecl, importc:"sapp_frame_duration".}
proc frameDuration*():cdouble =
    c_frameDuration()

proc c_setClipboardString(str:cstring):void {.cdecl, importc:"sapp_set_clipboard_string".}
proc setClipboardString*(str:cstring):void =
    c_setClipboardString(str)

proc c_getClipboardString():cstring {.cdecl, importc:"sapp_get_clipboard_string".}
proc getClipboardString*():cstring =
    c_getClipboardString()

proc c_setWindowTitle(str:cstring):void {.cdecl, importc:"sapp_set_window_title".}
proc setWindowTitle*(str:cstring):void =
    c_setWindowTitle(str)

proc c_setIcon(icon_desc:ptr IconDesc):void {.cdecl, importc:"sapp_set_icon".}
proc setIcon*(icon_desc:IconDesc):void =
    c_setIcon(unsafeAddr(icon_desc))

proc c_getNumDroppedFiles():cint {.cdecl, importc:"sapp_get_num_dropped_files".}
proc getNumDroppedFiles*():cint =
    c_getNumDroppedFiles()

proc c_getDroppedFilePath(index:cint):cstring {.cdecl, importc:"sapp_get_dropped_file_path".}
proc getDroppedFilePath*(index:cint):cstring =
    c_getDroppedFilePath(index)

proc c_run(desc:ptr Desc):void {.cdecl, importc:"sapp_run".}
proc run*(desc:Desc):void =
    c_run(unsafeAddr(desc))

proc c_gles2():bool {.cdecl, importc:"sapp_gles2".}
proc gles2*():bool =
    c_gles2()

proc c_html5AskLeaveSite(ask:bool):void {.cdecl, importc:"sapp_html5_ask_leave_site".}
proc html5AskLeaveSite*(ask:bool):void =
    c_html5AskLeaveSite(ask)

proc c_html5GetDroppedFileSize(index:cint):uint32 {.cdecl, importc:"sapp_html5_get_dropped_file_size".}
proc html5GetDroppedFileSize*(index:cint):uint32 =
    c_html5GetDroppedFileSize(index)

proc c_html5FetchDroppedFile(request:ptr Html5FetchRequest):void {.cdecl, importc:"sapp_html5_fetch_dropped_file".}
proc html5FetchDroppedFile*(request:Html5FetchRequest):void =
    c_html5FetchDroppedFile(unsafeAddr(request))

proc c_metalGetDevice():pointer {.cdecl, importc:"sapp_metal_get_device".}
proc metalGetDevice*():pointer =
    c_metalGetDevice()

proc c_metalGetRenderpassDescriptor():pointer {.cdecl, importc:"sapp_metal_get_renderpass_descriptor".}
proc metalGetRenderpassDescriptor*():pointer =
    c_metalGetRenderpassDescriptor()

proc c_metalGetDrawable():pointer {.cdecl, importc:"sapp_metal_get_drawable".}
proc metalGetDrawable*():pointer =
    c_metalGetDrawable()

proc c_macosGetWindow():pointer {.cdecl, importc:"sapp_macos_get_window".}
proc macosGetWindow*():pointer =
    c_macosGetWindow()

proc c_iosGetWindow():pointer {.cdecl, importc:"sapp_ios_get_window".}
proc iosGetWindow*():pointer =
    c_iosGetWindow()

proc c_d3d11GetDevice():pointer {.cdecl, importc:"sapp_d3d11_get_device".}
proc d3d11GetDevice*():pointer =
    c_d3d11GetDevice()

proc c_d3d11GetDeviceContext():pointer {.cdecl, importc:"sapp_d3d11_get_device_context".}
proc d3d11GetDeviceContext*():pointer =
    c_d3d11GetDeviceContext()

proc c_d3d11GetSwapChain():pointer {.cdecl, importc:"sapp_d3d11_get_swap_chain".}
proc d3d11GetSwapChain*():pointer =
    c_d3d11GetSwapChain()

proc c_d3d11GetRenderTargetView():pointer {.cdecl, importc:"sapp_d3d11_get_render_target_view".}
proc d3d11GetRenderTargetView*():pointer =
    c_d3d11GetRenderTargetView()

proc c_d3d11GetDepthStencilView():pointer {.cdecl, importc:"sapp_d3d11_get_depth_stencil_view".}
proc d3d11GetDepthStencilView*():pointer =
    c_d3d11GetDepthStencilView()

proc c_win32GetHwnd():pointer {.cdecl, importc:"sapp_win32_get_hwnd".}
proc win32GetHwnd*():pointer =
    c_win32GetHwnd()

proc c_wgpuGetDevice():pointer {.cdecl, importc:"sapp_wgpu_get_device".}
proc wgpuGetDevice*():pointer =
    c_wgpuGetDevice()

proc c_wgpuGetRenderView():pointer {.cdecl, importc:"sapp_wgpu_get_render_view".}
proc wgpuGetRenderView*():pointer =
    c_wgpuGetRenderView()

proc c_wgpuGetResolveView():pointer {.cdecl, importc:"sapp_wgpu_get_resolve_view".}
proc wgpuGetResolveView*():pointer =
    c_wgpuGetResolveView()

proc c_wgpuGetDepthStencilView():pointer {.cdecl, importc:"sapp_wgpu_get_depth_stencil_view".}
proc wgpuGetDepthStencilView*():pointer =
    c_wgpuGetDepthStencilView()

proc c_androidGetNativeActivity():pointer {.cdecl, importc:"sapp_android_get_native_activity".}
proc androidGetNativeActivity*():pointer =
    c_androidGetNativeActivity()

when defined windows:
  {.passl:"-lkernel32 -luser32 -lshell32 -lgdi32".}
  when defined gl:
    {.passc:"-DSOKOL_GLCORE33".}
  else:
    {.passc:"-DSOKOL_D3D11".}
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

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_app.c".}
