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

type Border* = object
  left*:int32
  right*:int32
  top*:int32
  bottom*:int32

type
  Anchor* {.size:sizeof(int32).} = enum
    anchorCenter = 0,
    anchorTop = 1,
    anchorBottom = 2,
    anchorLeft = 3,
    anchorRight = 4,

type LetterboxDesc* = object
  contentAspectRatio*:float32
  anchor*:Anchor
  border*:Border

type Viewport* = object
  x*:int32
  y*:int32
  width*:int32
  height*:int32

proc c_letterbox(width:int32, height:int32, desc:ptr LetterboxDesc):Viewport {.cdecl, importc:"slbx_letterbox".}
proc letterbox*(width:int32, height:int32, desc:LetterboxDesc):Viewport =
    c_letterbox(width, height, addr(desc))

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
{.compile:"c/sokol_letterbox.c".}
