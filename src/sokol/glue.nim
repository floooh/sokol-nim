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

proc c_environment():gfx.Environment {.cdecl, importc:"sglue_environment".}
proc environment*():gfx.Environment =
    c_environment()

proc c_swapchain():gfx.Swapchain {.cdecl, importc:"sglue_swapchain".}
proc swapchain*():gfx.Swapchain =
    c_swapchain()

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
{.compile:"c/sokol_glue.c".}
