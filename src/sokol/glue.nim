## machine generated, do not edit

import gfx

proc context*():gfx.ContextDesc {.cdecl, importc:"sapp_sgcontext".}

# Nim-specific API extensions
include extra/glue
