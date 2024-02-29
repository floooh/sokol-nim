## machine generated, do not edit

import gfx

proc c_environment():gfx.Environment {.cdecl, importc:"sglue_environment".}
proc environment*():gfx.Environment =
    c_environment()

proc c_swapchain():gfx.Swapchain {.cdecl, importc:"sglue_swapchain".}
proc swapchain*():gfx.Swapchain =
    c_swapchain()

{.passc:"-DSOKOL_NIM_IMPL".}
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_glue.c".}
