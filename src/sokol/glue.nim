## machine generated, do not edit

import gfx

proc c_context():gfx.ContextDesc {.cdecl, importc:"sapp_sgcontext".}
proc context*():gfx.ContextDesc =
    c_context()

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_glue.c".}
