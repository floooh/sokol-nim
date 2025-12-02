## machine generated, do not edit


const
  maxTouchpoints* = 8
  maxMousebuttons* = 3
  maxKeycodes* = 512
  maxIconimages* = 8

type
  EventType* {.size:sizeof(int32).} = enum
    eventTypeInvalid,
    eventTypeKeyDown,
    eventTypeKeyUp,
    eventTypeChar,
    eventTypeMouseDown,
    eventTypeMouseUp,
    eventTypeMouseScroll,
    eventTypeMouseMove,
    eventTypeMouseEnter,
    eventTypeMouseLeave,
    eventTypeTouchesBegan,
    eventTypeTouchesMoved,
    eventTypeTouchesEnded,
    eventTypeTouchesCancelled,
    eventTypeResized,
    eventTypeIconified,
    eventTypeRestored,
    eventTypeFocused,
    eventTypeUnfocused,
    eventTypeSuspended,
    eventTypeResumed,
    eventTypeQuitRequested,
    eventTypeClipboardPasted,
    eventTypeFilesDropped,

type
  Keycode* {.size:sizeof(int32).} = enum
    keyCodeInvalid = 0,
    keyCodeSpace = 32,
    keyCodeApostrophe = 39,
    keyCodeComma = 44,
    keyCodeMinus = 45,
    keyCodePeriod = 46,
    keyCodeSlash = 47,
    keyCode0 = 48,
    keyCode1 = 49,
    keyCode2 = 50,
    keyCode3 = 51,
    keyCode4 = 52,
    keyCode5 = 53,
    keyCode6 = 54,
    keyCode7 = 55,
    keyCode8 = 56,
    keyCode9 = 57,
    keyCodeSemicolon = 59,
    keyCodeEqual = 61,
    keyCodeA = 65,
    keyCodeB = 66,
    keyCodeC = 67,
    keyCodeD = 68,
    keyCodeE = 69,
    keyCodeF = 70,
    keyCodeG = 71,
    keyCodeH = 72,
    keyCodeI = 73,
    keyCodeJ = 74,
    keyCodeK = 75,
    keyCodeL = 76,
    keyCodeM = 77,
    keyCodeN = 78,
    keyCodeO = 79,
    keyCodeP = 80,
    keyCodeQ = 81,
    keyCodeR = 82,
    keyCodeS = 83,
    keyCodeT = 84,
    keyCodeU = 85,
    keyCodeV = 86,
    keyCodeW = 87,
    keyCodeX = 88,
    keyCodeY = 89,
    keyCodeZ = 90,
    keyCodeLeftBracket = 91,
    keyCodeBackslash = 92,
    keyCodeRightBracket = 93,
    keyCodeGraveAccent = 96,
    keyCodeWorld1 = 161,
    keyCodeWorld2 = 162,
    keyCodeEscape = 256,
    keyCodeEnter = 257,
    keyCodeTab = 258,
    keyCodeBackspace = 259,
    keyCodeInsert = 260,
    keyCodeDelete = 261,
    keyCodeRight = 262,
    keyCodeLeft = 263,
    keyCodeDown = 264,
    keyCodeUp = 265,
    keyCodePageUp = 266,
    keyCodePageDown = 267,
    keyCodeHome = 268,
    keyCodeEnd = 269,
    keyCodeCapsLock = 280,
    keyCodeScrollLock = 281,
    keyCodeNumLock = 282,
    keyCodePrintScreen = 283,
    keyCodePause = 284,
    keyCodeF1 = 290,
    keyCodeF2 = 291,
    keyCodeF3 = 292,
    keyCodeF4 = 293,
    keyCodeF5 = 294,
    keyCodeF6 = 295,
    keyCodeF7 = 296,
    keyCodeF8 = 297,
    keyCodeF9 = 298,
    keyCodeF10 = 299,
    keyCodeF11 = 300,
    keyCodeF12 = 301,
    keyCodeF13 = 302,
    keyCodeF14 = 303,
    keyCodeF15 = 304,
    keyCodeF16 = 305,
    keyCodeF17 = 306,
    keyCodeF18 = 307,
    keyCodeF19 = 308,
    keyCodeF20 = 309,
    keyCodeF21 = 310,
    keyCodeF22 = 311,
    keyCodeF23 = 312,
    keyCodeF24 = 313,
    keyCodeF25 = 314,
    keyCodeKp0 = 320,
    keyCodeKp1 = 321,
    keyCodeKp2 = 322,
    keyCodeKp3 = 323,
    keyCodeKp4 = 324,
    keyCodeKp5 = 325,
    keyCodeKp6 = 326,
    keyCodeKp7 = 327,
    keyCodeKp8 = 328,
    keyCodeKp9 = 329,
    keyCodeKpDecimal = 330,
    keyCodeKpDivide = 331,
    keyCodeKpMultiply = 332,
    keyCodeKpSubtract = 333,
    keyCodeKpAdd = 334,
    keyCodeKpEnter = 335,
    keyCodeKpEqual = 336,
    keyCodeLeftShift = 340,
    keyCodeLeftControl = 341,
    keyCodeLeftAlt = 342,
    keyCodeLeftSuper = 343,
    keyCodeRightShift = 344,
    keyCodeRightControl = 345,
    keyCodeRightAlt = 346,
    keyCodeRightSuper = 347,
    keyCodeMenu = 348,

type
  AndroidTooltype* {.size:sizeof(int32).} = enum
    androidtooltypeUnknown = 0,
    androidtooltypeFinger = 1,
    androidtooltypeStylus = 2,
    androidtooltypeMouse = 3,

type Touchpoint* = object
  identifier*:uint
  posX*:float32
  posY*:float32
  androidTooltype*:AndroidTooltype
  changed*:bool

type
  Mousebutton* {.size:sizeof(int32).} = enum
    mouseButtonLeft = 0,
    mouseButtonRight = 1,
    mouseButtonMiddle = 2,
    mouseButtonInvalid = 256,

const
  modifierShift* = 1
  modifierCtrl* = 2
  modifierAlt* = 4
  modifierSuper* = 8
  modifierLmb* = 256
  modifierRmb* = 512
  modifierMmb* = 1024

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

converter toEventtouches*[N:static[int]](items: array[N, Touchpoint]): array[8, Touchpoint] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

type Range* = object
  `addr`*:pointer
  size*:int

type ImageDesc* = object
  width*:int32
  height*:int32
  cursorHotspotX*:int32
  cursorHotspotY*:int32
  pixels*:Range

type IconDesc* = object
  sokolDefault*:bool
  images*:array[8, ImageDesc]

converter toIconDescimages*[N:static[int]](items: array[N, ImageDesc]): array[8, ImageDesc] =
  static: assert(N <= 8)
  for index,item in items.pairs: result[index]=item

type Allocator* = object
  allocFn*:proc(a1:int, a2:pointer):pointer {.cdecl.}
  freeFn*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemMacosInvalidNsopenglProfile,
    logitemWin32LoadOpengl32DllFailed,
    logitemWin32CreateHelperWindowFailed,
    logitemWin32HelperWindowGetdcFailed,
    logitemWin32DummyContextSetPixelformatFailed,
    logitemWin32CreateDummyContextFailed,
    logitemWin32DummyContextMakeCurrentFailed,
    logitemWin32GetPixelformatAttribFailed,
    logitemWin32WglFindPixelformatFailed,
    logitemWin32WglDescribePixelformatFailed,
    logitemWin32WglSetPixelformatFailed,
    logitemWin32WglArbCreateContextRequired,
    logitemWin32WglArbCreateContextProfileRequired,
    logitemWin32WglOpenglVersionNotSupported,
    logitemWin32WglOpenglProfileNotSupported,
    logitemWin32WglIncompatibleDeviceContext,
    logitemWin32WglCreateContextAttribsFailedOther,
    logitemWin32D3d11CreateDeviceAndSwapchainWithDebugFailed,
    logitemWin32D3d11GetIdxgifactoryFailed,
    logitemWin32D3d11GetIdxgiadapterFailed,
    logitemWin32D3d11QueryInterfaceIdxgidevice1Failed,
    logitemWin32RegisterRawInputDevicesFailedMouseLock,
    logitemWin32RegisterRawInputDevicesFailedMouseUnlock,
    logitemWin32GetRawInputDataFailed,
    logitemWin32DestroyiconForCursorFailed,
    logitemLinuxGlxLoadLibglFailed,
    logitemLinuxGlxLoadEntryPointsFailed,
    logitemLinuxGlxExtensionNotFound,
    logitemLinuxGlxQueryVersionFailed,
    logitemLinuxGlxVersionTooLow,
    logitemLinuxGlxNoGlxfbconfigs,
    logitemLinuxGlxNoSuitableGlxfbconfig,
    logitemLinuxGlxGetVisualFromFbconfigFailed,
    logitemLinuxGlxRequiredExtensionsMissing,
    logitemLinuxGlxCreateContextFailed,
    logitemLinuxGlxCreateWindowFailed,
    logitemLinuxX11CreateWindowFailed,
    logitemLinuxEglBindOpenglApiFailed,
    logitemLinuxEglBindOpenglEsApiFailed,
    logitemLinuxEglGetDisplayFailed,
    logitemLinuxEglInitializeFailed,
    logitemLinuxEglNoConfigs,
    logitemLinuxEglNoNativeVisual,
    logitemLinuxEglGetVisualInfoFailed,
    logitemLinuxEglCreateWindowSurfaceFailed,
    logitemLinuxEglCreateContextFailed,
    logitemLinuxEglMakeCurrentFailed,
    logitemLinuxX11OpenDisplayFailed,
    logitemLinuxX11QuerySystemDpiFailed,
    logitemLinuxX11DroppedFileUriWrongScheme,
    logitemLinuxX11FailedToBecomeOwnerOfClipboard,
    logitemAndroidUnsupportedInputEventInputCb,
    logitemAndroidUnsupportedInputEventMainCb,
    logitemAndroidReadMsgFailed,
    logitemAndroidWriteMsgFailed,
    logitemAndroidMsgCreate,
    logitemAndroidMsgResume,
    logitemAndroidMsgPause,
    logitemAndroidMsgFocus,
    logitemAndroidMsgNoFocus,
    logitemAndroidMsgSetNativeWindow,
    logitemAndroidMsgSetInputQueue,
    logitemAndroidMsgDestroy,
    logitemAndroidUnknownMsg,
    logitemAndroidLoopThreadStarted,
    logitemAndroidLoopThreadDone,
    logitemAndroidNativeActivityOnstart,
    logitemAndroidNativeActivityOnresume,
    logitemAndroidNativeActivityOnsaveinstancestate,
    logitemAndroidNativeActivityOnwindowfocuschanged,
    logitemAndroidNativeActivityOnpause,
    logitemAndroidNativeActivityOnstop,
    logitemAndroidNativeActivityOnnativewindowcreated,
    logitemAndroidNativeActivityOnnativewindowdestroyed,
    logitemAndroidNativeActivityOninputqueuecreated,
    logitemAndroidNativeActivityOninputqueuedestroyed,
    logitemAndroidNativeActivityOnconfigurationchanged,
    logitemAndroidNativeActivityOnlowmemory,
    logitemAndroidNativeActivityOndestroy,
    logitemAndroidNativeActivityDone,
    logitemAndroidNativeActivityOncreate,
    logitemAndroidCreateThreadPipeFailed,
    logitemAndroidNativeActivityCreateSuccess,
    logitemWgpuDeviceLost,
    logitemWgpuDeviceLog,
    logitemWgpuDeviceUncapturedError,
    logitemWgpuSwapchainCreateSurfaceFailed,
    logitemWgpuSwapchainSurfaceGetCapabilitiesFailed,
    logitemWgpuSwapchainCreateDepthStencilTextureFailed,
    logitemWgpuSwapchainCreateDepthStencilViewFailed,
    logitemWgpuSwapchainCreateMsaaTextureFailed,
    logitemWgpuSwapchainCreateMsaaViewFailed,
    logitemWgpuSwapchainGetcurrenttextureFailed,
    logitemWgpuRequestDeviceStatusError,
    logitemWgpuRequestDeviceStatusUnknown,
    logitemWgpuRequestAdapterStatusUnavailable,
    logitemWgpuRequestAdapterStatusError,
    logitemWgpuRequestAdapterStatusUnknown,
    logitemWgpuCreateInstanceFailed,
    logitemVulkanAllocDeviceMemoryNoSuitableMemoryType,
    logitemVulkanAllocateMemoryFailed,
    logitemVulkanCreateInstanceFailed,
    logitemVulkanEnumeratePhysicalDevicesFailed,
    logitemVulkanNoPhysicalDevicesFound,
    logitemVulkanNoSuitablePhysicalDeviceFound,
    logitemVulkanCreateDeviceFailedExtensionNotPresent,
    logitemVulkanCreateDeviceFailedFeatureNotPresent,
    logitemVulkanCreateDeviceFailedInitializationFailed,
    logitemVulkanCreateDeviceFailedOther,
    logitemVulkanCreateSurfaceFailed,
    logitemVulkanCreateSwapchainFailed,
    logitemVulkanSwapchainCreateImageViewFailed,
    logitemVulkanSwapchainCreateImageFailed,
    logitemVulkanSwapchainAllocImageDeviceMemoryFailed,
    logitemVulkanSwapchainBindImageMemoryFailed,
    logitemVulkanAcquireNextImageFailed,
    logitemVulkanQueuePresentFailed,
    logitemImageDataSizeMismatch,
    logitemDroppedFilePathTooLong,
    logitemClipboardStringTooBig,

type
  PixelFormat* {.size:sizeof(int32).} = enum
    pixelFormatDefault,
    pixelFormatNone,
    pixelFormatRgba8,
    pixelFormatSrgb8a8,
    pixelFormatBgra8,
    pixelFormatSbgra8,
    pixelFormatDepth,
    pixelFormatDepthStencil,

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

type VulkanEnvironment* = object
  physicalDevice*:pointer
  device*:pointer
  queue*:pointer
  queueFamilyIndex*:uint32

type Environment* = object
  defaults*:EnvironmentDefaults
  metal*:MetalEnvironment
  d3d11*:D3d11Environment
  wgpu*:WgpuEnvironment
  vulkan*:VulkanEnvironment

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

type VulkanSwapchain* = object
  renderImage*:pointer
  renderView*:pointer
  resolveImage*:pointer
  resolveView*:pointer
  depthStencilImage*:pointer
  depthStencilView*:pointer
  renderFinishedSemaphore*:pointer
  presentCompleteSemaphore*:pointer

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
  vulkan*:VulkanSwapchain
  gl*:GlSwapchain

type Logger* = object
  fn*:proc(a1:cstring, a2:uint32, a3:uint32, a4:cstring, a5:uint32, a6:cstring, a7:pointer) {.cdecl.}
  userData*:pointer

type GlDesc* = object
  majorVersion*:int32
  minorVersion*:int32

type Win32Desc* = object
  consoleUtf8*:bool
  consoleCreate*:bool
  consoleAttach*:bool

type Html5Desc* = object
  canvasSelector*:cstring
  canvasResize*:bool
  preserveDrawingBuffer*:bool
  premultipliedAlpha*:bool
  askLeaveSite*:bool
  updateDocumentTitle*:bool
  bubbleMouseEvents*:bool
  bubbleTouchEvents*:bool
  bubbleWheelEvents*:bool
  bubbleKeyEvents*:bool
  bubbleCharEvents*:bool
  useEmscSetMainLoop*:bool
  emscSetMainLoopSimulateInfiniteLoop*:bool

type IosDesc* = object
  keyboardResizesCanvas*:bool

type Desc* = object
  initCb*:proc() {.cdecl.}
  frameCb*:proc() {.cdecl.}
  cleanupCb*:proc() {.cdecl.}
  eventCb*:proc(a1:ptr Event) {.cdecl.}
  userData*:pointer
  initUserdataCb*:proc(a1:pointer) {.cdecl.}
  frameUserdataCb*:proc(a1:pointer) {.cdecl.}
  cleanupUserdataCb*:proc(a1:pointer) {.cdecl.}
  eventUserdataCb*:proc(a1:ptr Event, a2:pointer) {.cdecl.}
  width*:int32
  height*:int32
  sampleCount*:int32
  swapInterval*:int32
  highDpi*:bool
  fullscreen*:bool
  alpha*:bool
  windowTitle*:cstring
  enableClipboard*:bool
  clipboardSize*:int32
  enableDragndrop*:bool
  maxDroppedFiles*:int32
  maxDroppedFilePathLength*:int32
  icon*:IconDesc
  allocator*:Allocator
  logger*:Logger
  gl*:GlDesc
  win32*:Win32Desc
  html5*:Html5Desc
  ios*:IosDesc

type
  Html5FetchError* {.size:sizeof(int32).} = enum
    html5FetchErrorNoError,
    html5FetchErrorBufferTooSmall,
    html5FetchErrorOther,

type Html5FetchResponse* = object
  succeeded*:bool
  errorCode*:Html5FetchError
  fileIndex*:int32
  data*:Range
  buffer*:Range
  userData*:pointer

type Html5FetchRequest* = object
  droppedFileIndex*:int32
  callback*:proc(a1:ptr Html5FetchResponse) {.cdecl.}
  buffer*:Range
  userData*:pointer

type
  MouseCursor* {.size:sizeof(int32).} = enum
    mousecursorDefault = 0,
    mousecursorArrow = 1,
    mousecursorIbeam = 2,
    mousecursorCrosshair = 3,
    mousecursorPointingHand = 4,
    mousecursorResizeEw = 5,
    mousecursorResizeNs = 6,
    mousecursorResizeNwse = 7,
    mousecursorResizeNesw = 8,
    mousecursorResizeAll = 9,
    mousecursorNotAllowed = 10,
    mousecursorCustom0 = 11,
    mousecursorCustom1 = 12,
    mousecursorCustom2 = 13,
    mousecursorCustom3 = 14,
    mousecursorCustom4 = 15,
    mousecursorCustom5 = 16,
    mousecursorCustom6 = 17,
    mousecursorCustom7 = 18,
    mousecursorCustom8 = 19,
    mousecursorCustom9 = 20,
    mousecursorCustom10 = 21,
    mousecursorCustom11 = 22,
    mousecursorCustom12 = 23,
    mousecursorCustom13 = 24,
    mousecursorCustom14 = 25,
    mousecursorCustom15 = 26,

proc c_isvalid():bool {.cdecl, importc:"sapp_isvalid".}
proc isvalid*():bool =
    c_isvalid()

proc c_width():int32 {.cdecl, importc:"sapp_width".}
proc width*():int32 =
    c_width()

proc c_widthf():float32 {.cdecl, importc:"sapp_widthf".}
proc widthf*():float32 =
    c_widthf()

proc c_height():int32 {.cdecl, importc:"sapp_height".}
proc height*():int32 =
    c_height()

proc c_heightf():float32 {.cdecl, importc:"sapp_heightf".}
proc heightf*():float32 =
    c_heightf()

proc c_colorFormat():PixelFormat {.cdecl, importc:"sapp_color_format".}
proc colorFormat*():PixelFormat =
    c_colorFormat()

proc c_depthFormat():PixelFormat {.cdecl, importc:"sapp_depth_format".}
proc depthFormat*():PixelFormat =
    c_depthFormat()

proc c_sampleCount():int32 {.cdecl, importc:"sapp_sample_count".}
proc sampleCount*():int32 =
    c_sampleCount()

proc c_highDpi():bool {.cdecl, importc:"sapp_high_dpi".}
proc highDpi*():bool =
    c_highDpi()

proc c_dpiScale():float32 {.cdecl, importc:"sapp_dpi_scale".}
proc dpiScale*():float32 =
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

proc c_setMouseCursor(cursor:MouseCursor):void {.cdecl, importc:"sapp_set_mouse_cursor".}
proc setMouseCursor*(cursor:MouseCursor):void =
    c_setMouseCursor(cursor)

proc c_getMouseCursor():MouseCursor {.cdecl, importc:"sapp_get_mouse_cursor".}
proc getMouseCursor*():MouseCursor =
    c_getMouseCursor()

proc c_bindMouseCursorImage(cursor:MouseCursor, desc:ptr ImageDesc):MouseCursor {.cdecl, importc:"sapp_bind_mouse_cursor_image".}
proc bindMouseCursorImage*(cursor:MouseCursor, desc:ImageDesc):MouseCursor =
    c_bindMouseCursorImage(cursor, addr(desc))

proc c_unbindMouseCursorImage(cursor:MouseCursor):void {.cdecl, importc:"sapp_unbind_mouse_cursor_image".}
proc unbindMouseCursorImage*(cursor:MouseCursor):void =
    c_unbindMouseCursorImage(cursor)

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

proc c_frameDuration():float64 {.cdecl, importc:"sapp_frame_duration".}
proc frameDuration*():float64 =
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

proc c_setIcon(iconDesc:ptr IconDesc):void {.cdecl, importc:"sapp_set_icon".}
proc setIcon*(iconDesc:IconDesc):void =
    c_setIcon(addr(icon_desc))

proc c_getNumDroppedFiles():int32 {.cdecl, importc:"sapp_get_num_dropped_files".}
proc getNumDroppedFiles*():int32 =
    c_getNumDroppedFiles()

proc c_getDroppedFilePath(index:int32):cstring {.cdecl, importc:"sapp_get_dropped_file_path".}
proc getDroppedFilePath*(index:int32):cstring =
    c_getDroppedFilePath(index)

proc c_run(desc:ptr Desc):void {.cdecl, importc:"sapp_run".}
proc run*(desc:Desc):void =
    c_run(addr(desc))

proc c_getEnvironment():Environment {.cdecl, importc:"sapp_get_environment".}
proc getEnvironment*():Environment =
    c_getEnvironment()

proc c_getSwapchain():Swapchain {.cdecl, importc:"sapp_get_swapchain".}
proc getSwapchain*():Swapchain =
    c_getSwapchain()

proc c_eglGetDisplay():pointer {.cdecl, importc:"sapp_egl_get_display".}
proc eglGetDisplay*():pointer =
    c_eglGetDisplay()

proc c_eglGetContext():pointer {.cdecl, importc:"sapp_egl_get_context".}
proc eglGetContext*():pointer =
    c_eglGetContext()

proc c_html5AskLeaveSite(ask:bool):void {.cdecl, importc:"sapp_html5_ask_leave_site".}
proc html5AskLeaveSite*(ask:bool):void =
    c_html5AskLeaveSite(ask)

proc c_html5GetDroppedFileSize(index:int32):uint32 {.cdecl, importc:"sapp_html5_get_dropped_file_size".}
proc html5GetDroppedFileSize*(index:int32):uint32 =
    c_html5GetDroppedFileSize(index)

proc c_html5FetchDroppedFile(request:ptr Html5FetchRequest):void {.cdecl, importc:"sapp_html5_fetch_dropped_file".}
proc html5FetchDroppedFile*(request:Html5FetchRequest):void =
    c_html5FetchDroppedFile(addr(request))

proc c_macosGetWindow():pointer {.cdecl, importc:"sapp_macos_get_window".}
proc macosGetWindow*():pointer =
    c_macosGetWindow()

proc c_iosGetWindow():pointer {.cdecl, importc:"sapp_ios_get_window".}
proc iosGetWindow*():pointer =
    c_iosGetWindow()

proc c_d3d11GetSwapChain():pointer {.cdecl, importc:"sapp_d3d11_get_swap_chain".}
proc d3d11GetSwapChain*():pointer =
    c_d3d11GetSwapChain()

proc c_win32GetHwnd():pointer {.cdecl, importc:"sapp_win32_get_hwnd".}
proc win32GetHwnd*():pointer =
    c_win32GetHwnd()

proc c_glGetMajorVersion():int32 {.cdecl, importc:"sapp_gl_get_major_version".}
proc glGetMajorVersion*():int32 =
    c_glGetMajorVersion()

proc c_glGetMinorVersion():int32 {.cdecl, importc:"sapp_gl_get_minor_version".}
proc glGetMinorVersion*():int32 =
    c_glGetMinorVersion()

proc c_glIsGles():bool {.cdecl, importc:"sapp_gl_is_gles".}
proc glIsGles*():bool =
    c_glIsGles()

proc c_x11GetWindow():pointer {.cdecl, importc:"sapp_x11_get_window".}
proc x11GetWindow*():pointer =
    c_x11GetWindow()

proc c_x11GetDisplay():pointer {.cdecl, importc:"sapp_x11_get_display".}
proc x11GetDisplay*():pointer =
    c_x11GetDisplay()

proc c_androidGetNativeActivity():pointer {.cdecl, importc:"sapp_android_get_native_activity".}
proc androidGetNativeActivity*():pointer =
    c_androidGetNativeActivity()

when defined emscripten:
  {.passl:"-lGL -ldl".}
  {.passc:"-DSOKOL_GLES3".}
  {.passL: "-s MIN_WEBGL_VERSION=2 -s MAX_WEBGL_VERSION=2".}
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

{.passc:"-DSOKOL_NIM_IMPL".}
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_app.c".}
