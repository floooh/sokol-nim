# Platform specific compilation ------------------------------------------------

when defined(windows):
  {.passl:"-lgdi32 -lshell32 -luser32".}
elif defined(macosx):
  {.passc:"-x objective-c".}
  {.passl:"-framework Cocoa -framework QuartzCore".}
elif defined(ios):
  {.passc:"-x objective-c".}
  {.passl:"-framework Foundation -framework UIKit".}
else:
  {.passl:"-lX11 -lXi -lXcursor -ldl -lpthread -lm".}

# Implementation ---------------------------------------------------------------

{.passc:"-DSOKOL_IMPL".}
{.compile:"../c/sokol_app.c".}