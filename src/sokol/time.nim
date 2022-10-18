## machine generated, do not edit


proc c_setup():void {.cdecl, importc:"stm_setup".}
proc setup*():void =
    c_setup()

proc c_now():uint64 {.cdecl, importc:"stm_now".}
proc now*():uint64 =
    c_now()

proc c_diff(newTicks:uint64, oldTicks:uint64):uint64 {.cdecl, importc:"stm_diff".}
proc diff*(newTicks:uint64, oldTicks:uint64):uint64 =
    c_diff(new_ticks, old_ticks)

proc c_since(startTicks:uint64):uint64 {.cdecl, importc:"stm_since".}
proc since*(startTicks:uint64):uint64 =
    c_since(start_ticks)

proc c_laptime(lastTime:ptr uint64):uint64 {.cdecl, importc:"stm_laptime".}
proc laptime*(lastTime:ptr uint64):uint64 =
    c_laptime(last_time)

proc c_roundToCommonRefreshRate(frameTicks:uint64):uint64 {.cdecl, importc:"stm_round_to_common_refresh_rate".}
proc roundToCommonRefreshRate*(frameTicks:uint64):uint64 =
    c_roundToCommonRefreshRate(frame_ticks)

proc c_sec(ticks:uint64):float64 {.cdecl, importc:"stm_sec".}
proc sec*(ticks:uint64):float64 =
    c_sec(ticks)

proc c_ms(ticks:uint64):float64 {.cdecl, importc:"stm_ms".}
proc ms*(ticks:uint64):float64 =
    c_ms(ticks)

proc c_us(ticks:uint64):float64 {.cdecl, importc:"stm_us".}
proc us*(ticks:uint64):float64 =
    c_us(ticks)

proc c_ns(ticks:uint64):float64 {.cdecl, importc:"stm_ns".}
proc ns*(ticks:uint64):float64 =
    c_ns(ticks)

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_time.c".}
