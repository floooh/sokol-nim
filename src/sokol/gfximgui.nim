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

type Allocator* = object
  allocFn*:proc(a1:int, a2:nil pointer):nil pointer {.cdecl.}
  freeFn*:proc(a1:nil pointer, a2:nil pointer) {.cdecl.}
  userData*:nil pointer

type Desc* = object
  allocator*:Allocator

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sgimgui_setup".}
proc setup*(desc:Desc):void =
    c_setup(addr(desc))

proc c_shutdown():void {.cdecl, importc:"sgimgui_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_draw():void {.cdecl, importc:"sgimgui_draw".}
proc draw*():void =
    c_draw()

proc c_drawMenu(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_menu".}
proc drawMenu*(title:nil cstring):void =
    c_drawMenu(title)

proc c_drawBufferWindowContent():void {.cdecl, importc:"sgimgui_draw_buffer_window_content".}
proc drawBufferWindowContent*():void =
    c_drawBufferWindowContent()

proc c_drawImageWindowContent():void {.cdecl, importc:"sgimgui_draw_image_window_content".}
proc drawImageWindowContent*():void =
    c_drawImageWindowContent()

proc c_drawSamplerWindowContent():void {.cdecl, importc:"sgimgui_draw_sampler_window_content".}
proc drawSamplerWindowContent*():void =
    c_drawSamplerWindowContent()

proc c_drawShaderWindowContent():void {.cdecl, importc:"sgimgui_draw_shader_window_content".}
proc drawShaderWindowContent*():void =
    c_drawShaderWindowContent()

proc c_drawPipelineWindowContent():void {.cdecl, importc:"sgimgui_draw_pipeline_window_content".}
proc drawPipelineWindowContent*():void =
    c_drawPipelineWindowContent()

proc c_drawViewWindowContent():void {.cdecl, importc:"sgimgui_draw_view_window_content".}
proc drawViewWindowContent*():void =
    c_drawViewWindowContent()

proc c_drawCaptureWindowContent():void {.cdecl, importc:"sgimgui_draw_capture_window_content".}
proc drawCaptureWindowContent*():void =
    c_drawCaptureWindowContent()

proc c_drawCapabilitiesWindowContent():void {.cdecl, importc:"sgimgui_draw_capabilities_window_content".}
proc drawCapabilitiesWindowContent*():void =
    c_drawCapabilitiesWindowContent()

proc c_drawFrameStatsWindowContent():void {.cdecl, importc:"sgimgui_draw_frame_stats_window_content".}
proc drawFrameStatsWindowContent*():void =
    c_drawFrameStatsWindowContent()

proc c_drawBufferWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_buffer_window".}
proc drawBufferWindow*(title:nil cstring):void =
    c_drawBufferWindow(title)

proc c_drawImageWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_image_window".}
proc drawImageWindow*(title:nil cstring):void =
    c_drawImageWindow(title)

proc c_drawSamplerWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_sampler_window".}
proc drawSamplerWindow*(title:nil cstring):void =
    c_drawSamplerWindow(title)

proc c_drawShaderWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_shader_window".}
proc drawShaderWindow*(title:nil cstring):void =
    c_drawShaderWindow(title)

proc c_drawPipelineWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_pipeline_window".}
proc drawPipelineWindow*(title:nil cstring):void =
    c_drawPipelineWindow(title)

proc c_drawViewWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_view_window".}
proc drawViewWindow*(title:nil cstring):void =
    c_drawViewWindow(title)

proc c_drawCaptureWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_capture_window".}
proc drawCaptureWindow*(title:nil cstring):void =
    c_drawCaptureWindow(title)

proc c_drawCapabilitiesWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_capabilities_window".}
proc drawCapabilitiesWindow*(title:nil cstring):void =
    c_drawCapabilitiesWindow(title)

proc c_drawFrameStatsWindow(title:nil cstring):void {.cdecl, importc:"sgimgui_draw_frame_stats_window".}
proc drawFrameStatsWindow*(title:nil cstring):void =
    c_drawFrameStatsWindow(title)

proc c_drawBufferMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_buffer_menu_item".}
proc drawBufferMenuItem*(label:nil cstring):void =
    c_drawBufferMenuItem(label)

proc c_drawImageMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_image_menu_item".}
proc drawImageMenuItem*(label:nil cstring):void =
    c_drawImageMenuItem(label)

proc c_drawSamplerMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_sampler_menu_item".}
proc drawSamplerMenuItem*(label:nil cstring):void =
    c_drawSamplerMenuItem(label)

proc c_drawShaderMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_shader_menu_item".}
proc drawShaderMenuItem*(label:nil cstring):void =
    c_drawShaderMenuItem(label)

proc c_drawPipelineMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_pipeline_menu_item".}
proc drawPipelineMenuItem*(label:nil cstring):void =
    c_drawPipelineMenuItem(label)

proc c_drawViewMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_view_menu_item".}
proc drawViewMenuItem*(label:nil cstring):void =
    c_drawViewMenuItem(label)

proc c_drawCaptureMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_capture_menu_item".}
proc drawCaptureMenuItem*(label:nil cstring):void =
    c_drawCaptureMenuItem(label)

proc c_drawCapabilitiesMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_capabilities_menu_item".}
proc drawCapabilitiesMenuItem*(label:nil cstring):void =
    c_drawCapabilitiesMenuItem(label)

proc c_drawFrameStatsMenuItem(label:nil cstring):void {.cdecl, importc:"sgimgui_draw_frame_stats_menu_item".}
proc drawFrameStatsMenuItem*(label:nil cstring):void =
    c_drawFrameStatsMenuItem(label)

{.passC:"-DIMPL".}
when defined(release):
  {.passC:"-DNDEBUG".}
