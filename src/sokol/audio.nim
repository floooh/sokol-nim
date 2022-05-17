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

proc setup*(desc:ptr Desc):void {.cdecl, importc:"saudio_setup".}

proc shutdown*():void {.cdecl, importc:"saudio_shutdown".}

proc isvalid*():bool {.cdecl, importc:"saudio_isvalid".}

proc userdata*():pointer {.cdecl, importc:"saudio_userdata".}

proc queryDesc*():Desc {.cdecl, importc:"saudio_query_desc".}

proc sampleRate*():cint {.cdecl, importc:"saudio_sample_rate".}

proc bufferFrames*():cint {.cdecl, importc:"saudio_buffer_frames".}

proc channels*():cint {.cdecl, importc:"saudio_channels".}

proc suspended*():bool {.cdecl, importc:"saudio_suspended".}

proc expect*():cint {.cdecl, importc:"saudio_expect".}

proc push*(frames:ptr cfloat, num_frames:cint):cint {.cdecl, importc:"saudio_push".}

# Nim-specific API extensions
include extra/audio
