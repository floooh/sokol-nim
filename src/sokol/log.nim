## machine generated, do not edit


proc fn*(tag:cstring, logLevel:uint32, logItem:uint32, message:cstring, lineNr:uint32, filename:cstring, userData:pointer):void {.cdecl, importc:"slog_func".}

{.passc:"-DSOKOL_NIM_IMPL".}
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_log.c".}
