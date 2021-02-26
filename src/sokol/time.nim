## machine generated, do not edit

proc setup*():void {.cdecl, importc:"stm_setup".}

proc now*():uint64 {.cdecl, importc:"stm_now".}

proc diff*(new_ticks:uint64, old_ticks:uint64):uint64 {.cdecl, importc:"stm_diff".}

proc since*(start_ticks:uint64):uint64 {.cdecl, importc:"stm_since".}

proc laptime*(last_time:ptr uint64):uint64 {.cdecl, importc:"stm_laptime".}

proc roundToCommonRefreshRate*(frame_ticks:uint64):uint64 {.cdecl, importc:"stm_round_to_common_refresh_rate".}

proc sec*(ticks:uint64):float64 {.cdecl, importc:"stm_sec".}

proc ms*(ticks:uint64):float64 {.cdecl, importc:"stm_ms".}

proc us*(ticks:uint64):float64 {.cdecl, importc:"stm_us".}

proc ns*(ticks:uint64):float64 {.cdecl, importc:"stm_ns".}

# Nim-specific API extensions
include ext/time
