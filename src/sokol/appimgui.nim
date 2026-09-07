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
import app

proc c_setup():void {.cdecl, importc:"sappimgui_setup".}
proc setup*():void =
    c_setup()

proc c_shutdown():void {.cdecl, importc:"sappimgui_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_trackFrame():void {.cdecl, importc:"sappimgui_track_frame".}
proc trackFrame*():void =
    c_trackFrame()

proc c_trackEvent(ev:ptr app.Event):void {.cdecl, importc:"sappimgui_track_event".}
proc trackEvent*(ev:app.Event):void =
    c_trackEvent(addr(ev))

proc c_draw():void {.cdecl, importc:"sappimgui_draw".}
proc draw*():void =
    c_draw()

proc c_drawMenu(title:nil cstring):void {.cdecl, importc:"sappimgui_draw_menu".}
proc drawMenu*(title:nil cstring):void =
    c_drawMenu(title)

proc c_drawHudWindowContent():void {.cdecl, importc:"sappimgui_draw_hud_window_content".}
proc drawHudWindowContent*():void =
    c_drawHudWindowContent()

proc c_drawPublicstateWindowContent():void {.cdecl, importc:"sappimgui_draw_publicstate_window_content".}
proc drawPublicstateWindowContent*():void =
    c_drawPublicstateWindowContent()

proc c_drawEventWindowContent():void {.cdecl, importc:"sappimgui_draw_event_window_content".}
proc drawEventWindowContent*():void =
    c_drawEventWindowContent()

proc c_drawHudWindow(title:nil cstring):void {.cdecl, importc:"sappimgui_draw_hud_window".}
proc drawHudWindow*(title:nil cstring):void =
    c_drawHudWindow(title)

proc c_drawPublicstateWindow(title:nil cstring):void {.cdecl, importc:"sappimgui_draw_publicstate_window".}
proc drawPublicstateWindow*(title:nil cstring):void =
    c_drawPublicstateWindow(title)

proc c_drawEventWindow(title:nil cstring):void {.cdecl, importc:"sappimgui_draw_event_window".}
proc drawEventWindow*(title:nil cstring):void =
    c_drawEventWindow(title)

proc c_drawHudMenuItem(label:nil cstring):void {.cdecl, importc:"sappimgui_draw_hud_menu_item".}
proc drawHudMenuItem*(label:nil cstring):void =
    c_drawHudMenuItem(label)

proc c_drawPublicstateMenuItem(label:nil cstring):void {.cdecl, importc:"sappimgui_draw_publicstate_menu_item".}
proc drawPublicstateMenuItem*(label:nil cstring):void =
    c_drawPublicstateMenuItem(label)

proc c_drawEventMenuItem(label:nil cstring):void {.cdecl, importc:"sappimgui_draw_event_menu_item".}
proc drawEventMenuItem*(label:nil cstring):void =
    c_drawEventMenuItem(label)

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
