## machine generated, do not edit

type Desc* = object
  sampleRate*:int32
  numChannels*:int32
  bufferFrames*:int32
  packetFrames*:int32
  numPackets*:int32
  streamCb*:proc(a1:[*c] float32, a2:int32, a3:int32) {.cdecl.}
  streamUserdataCb*:proc(a1:[*c] float32, a2:int32, a3:int32, a4:pointer) {.cdecl.}
  userData*:pointer

proc setup*(desc:ptr Desc):void {.cdecl, importc:"saudio_setup".}

proc shutdown*():void {.cdecl, importc:"saudio_shutdown".}

proc isvalid*():bool {.cdecl, importc:"saudio_isvalid".}

proc userdata*():pointer {.cdecl, importc:"saudio_userdata".}

proc queryDesc*():Desc {.cdecl, importc:"saudio_query_desc".}

proc sampleRate*():int32 {.cdecl, importc:"saudio_sample_rate".}

proc bufferFrames*():int32 {.cdecl, importc:"saudio_buffer_frames".}

proc channels*():int32 {.cdecl, importc:"saudio_channels".}

proc expect*():int32 {.cdecl, importc:"saudio_expect".}

proc push*(frames:ptr float32, num_frames:int32):int32 {.cdecl, importc:"saudio_push".}

# Nim-specific API extensions
include ext/audio
