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

proc fn*(tag:cstring, logLevel:uint32, logItem:uint32, message:cstring, lineNr:uint32, filename:cstring, userData:pointer):void {.cdecl, importc:"slog_func".}

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
{.compile:"c/sokol_log.c".}
