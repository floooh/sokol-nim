## machine generated, do not edit

type Allocator* = object
  alloc*:proc(a1:csize_t, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  sampleRate*:cint
  numChannels*:cint
  bufferFrames*:cint
  packetFrames*:cint
  numPackets*:cint
  streamCb*:proc(a1:ptr cfloat, a2:cint, a3:cint) {.cdecl.}
  streamUserdataCb*:proc(a1:ptr cfloat, a2:cint, a3:cint, a4:pointer) {.cdecl.}
  userData*:pointer
  allocator*:Allocator

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"saudio_setup".}
proc setup*(desc:Desc):void =
    c_setup(unsafeAddr(desc))

proc c_shutdown():void {.cdecl, importc:"saudio_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_isvalid():bool {.cdecl, importc:"saudio_isvalid".}
proc isvalid*():bool =
    c_isvalid()

proc c_userdata():pointer {.cdecl, importc:"saudio_userdata".}
proc userdata*():pointer =
    c_userdata()

proc c_queryDesc():Desc {.cdecl, importc:"saudio_query_desc".}
proc queryDesc*():Desc =
    c_queryDesc()

proc c_sampleRate():cint {.cdecl, importc:"saudio_sample_rate".}
proc sampleRate*():cint =
    c_sampleRate()

proc c_bufferFrames():cint {.cdecl, importc:"saudio_buffer_frames".}
proc bufferFrames*():cint =
    c_bufferFrames()

proc c_channels():cint {.cdecl, importc:"saudio_channels".}
proc channels*():cint =
    c_channels()

proc c_suspended():bool {.cdecl, importc:"saudio_suspended".}
proc suspended*():bool =
    c_suspended()

proc c_expect():cint {.cdecl, importc:"saudio_expect".}
proc expect*():cint =
    c_expect()

proc c_push(frames:ptr cfloat, num_frames:cint):cint {.cdecl, importc:"saudio_push".}
proc push*(frames:ptr cfloat, num_frames:cint):cint =
    c_push(frames, num_frames)

# Nim-specific API extensions
include extra/audio
