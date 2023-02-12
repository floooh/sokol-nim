## machine generated, do not edit


type
  LogItem* {.size:sizeof(int32).} = enum
    logitemOk,
    logitemMallocFailed,
    logitemAlsaSndPcmOpenFailed,
    logitemAlsaFloatSamplesNotSupported,
    logitemAlsaRequestedBufferSizeNotSupported,
    logitemAlsaRequestedChannelCountNotSupported,
    logitemAlsaSndPcmHwParamsSetRateNearFailed,
    logitemAlsaSndPcmHwParamsFailed,
    logitemAlsaPthreadCreateFailed,
    logitemWasapiCreateEventFailed,
    logitemWasapiCreateDeviceEnumeratorFailed,
    logitemWasapiGetDefaultAudioEndpointFailed,
    logitemWasapiDeviceActivateFailed,
    logitemWasapiAudioClientInitializeFailed,
    logitemWasapiAudioClientGetBufferSizeFailed,
    logitemWasapiAudioClientGetServiceFailed,
    logitemWasapiAudioClientSetEventHandleFailed,
    logitemWasapiCreateThreadFailed,
    logitemAaudioStreambuilderOpenStreamFailed,
    logitemAaudioPthreadCreateFailed,
    logitemAaudioRestartingStreamAfterError,
    logitemUsingAaudioBackend,
    logitemAaudioCreateStreambuilderFailed,
    logitemUsingSlesBackend,
    logitemSlesCreateEngineFailed,
    logitemSlesEngineGetEngineInterfaceFailed,
    logitemSlesCreateOutputMixFailed,
    logitemSlesMixerGetVolumeInterfaceFailed,
    logitemSlesEngineCreateAudioPlayerFailed,
    logitemSlesPlayerGetPlayInterfaceFailed,
    logitemSlesPlayerGetVolumeInterfaceFailed,
    logitemSlesPlayerGetBufferqueueInterfaceFailed,
    logitemCoreaudioNewOutputFailed,
    logitemCoreaudioAllocateBufferFailed,
    logitemCoreaudioStartFailed,
    logitemBackendBufferSizeIsntMultipleOfPacketSize,

type Logger* = object
  fn*:proc(a1:cstring, a2:uint32, a3:uint32, a4:cstring, a5:uint32, a6:cstring, a7:pointer) {.cdecl.}
  userData*:pointer

type Allocator* = object
  alloc*:proc(a1:int, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  sampleRate*:int32
  numChannels*:int32
  bufferFrames*:int32
  packetFrames*:int32
  numPackets*:int32
  streamCb*:proc(a1:ptr float32, a2:int32, a3:int32) {.cdecl.}
  streamUserdataCb*:proc(a1:ptr float32, a2:int32, a3:int32, a4:pointer) {.cdecl.}
  userData*:pointer
  allocator*:Allocator
  logger*:Logger

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

proc c_sampleRate():int32 {.cdecl, importc:"saudio_sample_rate".}
proc sampleRate*():int32 =
    c_sampleRate()

proc c_bufferFrames():int32 {.cdecl, importc:"saudio_buffer_frames".}
proc bufferFrames*():int32 =
    c_bufferFrames()

proc c_channels():int32 {.cdecl, importc:"saudio_channels".}
proc channels*():int32 =
    c_channels()

proc c_suspended():bool {.cdecl, importc:"saudio_suspended".}
proc suspended*():bool =
    c_suspended()

proc c_expect():int32 {.cdecl, importc:"saudio_expect".}
proc expect*():int32 =
    c_expect()

proc c_push(frames:ptr float32, numFrames:int32):int32 {.cdecl, importc:"saudio_push".}
proc push*(frames:ptr float32, numFrames:int32):int32 =
    c_push(frames, num_frames)

when defined windows:
  when not defined vcc:
    {.passl:"-lkernel32 -lole32".}
elif defined macosx:
  {.passl:"-framework AudioToolbox".}
elif defined linux:
  {.passl:"-lasound -lm -lpthread".}
else:
  error("unsupported platform")

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_audio.c".}
