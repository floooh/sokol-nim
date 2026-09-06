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

const
  invalidId* = 0

type Cmdbuf* = object
  id*:uint32

type
  ResourceState* {.size:sizeof(int32).} = enum
    resourceStateInitial,
    resourceStateAlloc,
    resourceStateValid,
    resourceStateFailed,
    resourceStateInvalid,

type CmdbufDesc* = object
  size*:int
  label*:nil cstring

type CmdbufInfo* = object
  size*:int
  remaining*:int
  overflown*:bool

type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemCmdbufPoolExhausted,
    logitemCmdbufOverflow,
    logitemCmdbufNotValid,
    logitemSubmitCmdbufOverflown,
    logitemSubmitInvalidCommand,

type Logger* = object
  fn*:proc(a1:nil cstring, a2:uint32, a3:uint32, a4:nil cstring, a5:uint32, a6:nil cstring, a7:nil pointer) {.cdecl.}
  userData*:nil pointer

type Allocator* = object
  allocFn*:proc(a1:int, a2:nil pointer):nil pointer {.cdecl.}
  freeFn*:proc(a1:nil pointer, a2:nil pointer) {.cdecl.}
  userData*:nil pointer

type Desc* = object
  cmdbufPoolSize*:int32
  allocator*:Allocator
  logger*:Logger

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"scb_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

proc c_shutdown():void {.cdecl, importc:"scb_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_makeCmdbuf(desc:ptr CmdbufDesc):Cmdbuf {.cdecl, importc:"scb_make_cmdbuf".}
proc makeCmdbuf*(desc:CmdbufDesc):Cmdbuf =
    c_makeCmdbuf(addr(desc))

proc c_destroyCmdbuf(cb:Cmdbuf):void {.cdecl, importc:"scb_destroy_cmdbuf".}
proc destroyCmdbuf*(cb:Cmdbuf):void =
    c_destroyCmdbuf(cb)

proc c_submit(cb:Cmdbuf):void {.cdecl, importc:"scb_submit".}
proc submit*(cb:Cmdbuf):void =
    c_submit(cb)

proc c_reset(cb:Cmdbuf):void {.cdecl, importc:"scb_reset".}
proc reset*(cb:Cmdbuf):void =
    c_reset(cb)

proc c_applyViewport(cb:Cmdbuf, x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void {.cdecl, importc:"scb_apply_viewport".}
proc applyViewport*(cb:Cmdbuf, x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void =
    c_applyViewport(cb, x, y, width, height, originTopLeft)

proc c_applyViewportf(cb:Cmdbuf, x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void {.cdecl, importc:"scb_apply_viewportf".}
proc applyViewportf*(cb:Cmdbuf, x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void =
    c_applyViewportf(cb, x, y, width, height, originTopLeft)

proc c_applyScissorRect(cb:Cmdbuf, x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void {.cdecl, importc:"scb_apply_scissor_rect".}
proc applyScissorRect*(cb:Cmdbuf, x:int32, y:int32, width:int32, height:int32, originTopLeft:bool):void =
    c_applyScissorRect(cb, x, y, width, height, originTopLeft)

proc c_applyScissorRectf(cb:Cmdbuf, x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void {.cdecl, importc:"scb_apply_scissor_rectf".}
proc applyScissorRectf*(cb:Cmdbuf, x:float32, y:float32, width:float32, height:float32, originTopLeft:bool):void =
    c_applyScissorRectf(cb, x, y, width, height, originTopLeft)

proc c_applyPipeline(cb:Cmdbuf, pip:gfx.Pipeline):void {.cdecl, importc:"scb_apply_pipeline".}
proc applyPipeline*(cb:Cmdbuf, pip:gfx.Pipeline):void =
    c_applyPipeline(cb, pip)

proc c_applyBindings(cb:Cmdbuf, bindings:ptr gfx.Bindings):void {.cdecl, importc:"scb_apply_bindings".}
proc applyBindings*(cb:Cmdbuf, bindings:gfx.Bindings):void =
    c_applyBindings(cb, addr(bindings))

proc c_applyUniforms(cb:Cmdbuf, ubSlot:int32, data:ptr gfx.Range):void {.cdecl, importc:"scb_apply_uniforms".}
proc applyUniforms*(cb:Cmdbuf, ubSlot:int32, data:gfx.Range):void =
    c_applyUniforms(cb, ubSlot, addr(data))

proc c_draw(cb:Cmdbuf, baseElement:int32, numElements:int32, numInstances:int32):void {.cdecl, importc:"scb_draw".}
proc draw*(cb:Cmdbuf, baseElement:int32, numElements:int32, numInstances:int32):void =
    c_draw(cb, baseElement, numElements, numInstances)

proc c_drawEx(cb:Cmdbuf, baseElement:int32, numElements:int32, numInstances:int32, baseVertex:int32, baseInstance:int32):void {.cdecl, importc:"scb_draw_ex".}
proc drawEx*(cb:Cmdbuf, baseElement:int32, numElements:int32, numInstances:int32, baseVertex:int32, baseInstance:int32):void =
    c_drawEx(cb, baseElement, numElements, numInstances, baseVertex, baseInstance)

proc c_dispatch(cb:Cmdbuf, numGroupsX:int32, numGroupsY:int32, numGroupsZ:int32):void {.cdecl, importc:"scb_dispatch".}
proc dispatch*(cb:Cmdbuf, numGroupsX:int32, numGroupsY:int32, numGroupsZ:int32):void =
    c_dispatch(cb, numGroupsX, numGroupsY, numGroupsZ)

proc c_queryCmdbufState(cb:Cmdbuf):ResourceState {.cdecl, importc:"scb_query_cmdbuf_state".}
proc queryCmdbufState*(cb:Cmdbuf):ResourceState =
    c_queryCmdbufState(cb)

proc c_queryCmdbufInfo(cb:Cmdbuf):CmdbufInfo {.cdecl, importc:"scb_query_cmdbuf_info".}
proc queryCmdbufInfo*(cb:Cmdbuf):CmdbufInfo =
    c_queryCmdbufInfo(cb)

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
{.compile:"c/sokol_cmdbuf.c".}
