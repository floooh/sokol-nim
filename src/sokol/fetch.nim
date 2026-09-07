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

type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemFilePathUtf8DecodingFailed,
    logitemSendQueueFull,
    logitemRequestChannelIndexTooBig,
    logitemRequestPathIsNull,
    logitemRequestPathTooLong,
    logitemRequestCallbackMissing,
    logitemRequestChunkSizeGreaterBufferSize,
    logitemRequestUserdataPtrIsSetButUserdataSizeIsNull,
    logitemRequestUserdataPtrIsNullButUserdataSizeIsNot,
    logitemRequestUserdataSizeTooBig,
    logitemClampingNumChannelsToMaxChannels,
    logitemRequestPoolExhausted,

type Logger* = object
  fn*:proc(a1:nil cstring, a2:uint32, a3:uint32, a4:nil cstring, a5:uint32, a6:nil cstring, a7:nil pointer) {.cdecl.}
  userData*:nil pointer

type Range* = object
  `addr`*:nil pointer
  size*:int

type Allocator* = object
  allocFn*:proc(a1:int, a2:nil pointer):nil pointer {.cdecl.}
  freeFn*:proc(a1:nil pointer, a2:nil pointer) {.cdecl.}
  userData*:nil pointer

type Desc* = object
  maxRequests*:uint32
  numChannels*:uint32
  numLanes*:uint32
  allocator*:Allocator
  logger*:Logger

type Handle* = object
  id*:uint32

type
  Error* {.size:sizeof(int32).} = enum
    errorNoError,
    errorFileNotFound,
    errorNoBuffer,
    errorBufferTooSmall,
    errorUnexpectedEof,
    errorInvalidHttpStatus,
    errorCancelled,
    errorJsOther,

type Response* = object
  handle*:Handle
  dispatched*:bool
  fetched*:bool
  paused*:bool
  finished*:bool
  failed*:bool
  cancelled*:bool
  errorCode*:Error
  channel*:uint32
  lane*:uint32
  path*:nil cstring
  userData*:nil pointer
  dataOffset*:uint32
  data*:Range
  buffer*:Range

type Request* = object
  channel*:uint32
  path*:nil cstring
  callback*:proc(a1:ptr Response) {.cdecl.}
  chunkSize*:uint32
  buffer*:Range
  userData*:Range

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sfetch_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

proc c_shutdown():void {.cdecl, importc:"sfetch_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_valid():bool {.cdecl, importc:"sfetch_valid".}
proc valid*():bool =
    c_valid()

proc c_desc():Desc {.cdecl, importc:"sfetch_desc".}
proc desc*():Desc =
    c_desc()

proc c_maxUserdataBytes():int32 {.cdecl, importc:"sfetch_max_userdata_bytes".}
proc maxUserdataBytes*():int32 =
    c_maxUserdataBytes()

proc c_maxPath():int32 {.cdecl, importc:"sfetch_max_path".}
proc maxPath*():int32 =
    c_maxPath()

proc c_send(request:ptr Request):Handle {.cdecl, importc:"sfetch_send".}
proc send*(request:Request):Handle =
    c_send(addr(request))

proc c_handleValid(h:Handle):bool {.cdecl, importc:"sfetch_handle_valid".}
proc handleValid*(h:Handle):bool =
    c_handleValid(h)

proc c_dowork():void {.cdecl, importc:"sfetch_dowork".}
proc dowork*():void =
    c_dowork()

proc c_bindBuffer(h:Handle, buffer:Range):void {.cdecl, importc:"sfetch_bind_buffer".}
proc bindBuffer*(h:Handle, buffer:Range):void =
    c_bindBuffer(h, buffer)

proc c_unbindBuffer(h:Handle):nil pointer {.cdecl, importc:"sfetch_unbind_buffer".}
proc unbindBuffer*(h:Handle):nil pointer =
    c_unbindBuffer(h)

proc c_cancel(h:Handle):void {.cdecl, importc:"sfetch_cancel".}
proc cancel*(h:Handle):void =
    c_cancel(h)

proc c_pause(h:Handle):void {.cdecl, importc:"sfetch_pause".}
proc pause*(h:Handle):void =
    c_pause(h)

proc c_continue(h:Handle):void {.cdecl, importc:"sfetch_continue".}
proc `continue`*(h:Handle):void =
    c_continue(h)

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
{.compile:"c/sokol_fetch.c".}
