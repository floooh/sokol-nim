## machine generated, do not edit

import gfx

type Pipeline* = object
  id*:uint32

type Context* = object
  id*:uint32

type
  Error* {.size:sizeof(int32).} = enum
    noError = 0,
    errorVerticesFull = 1,
    errorUniformsFull = 2,
    errorCommandsFull = 3,
    errorStackOverflow = 4,
    errorStackUnderflow = 5,
    errorNoContext = 6,

type ContextDesc* = object
  maxVertices*:cint
  maxCommands*:cint
  colorFormat*:gfx.PixelFormat
  depthFormat*:gfx.PixelFormat
  sampleCount*:cint

type Allocator* = object
  alloc*:proc(a1:csize_t, a2:pointer):pointer {.cdecl.}
  free*:proc(a1:pointer, a2:pointer) {.cdecl.}
  userData*:pointer

type Desc* = object
  maxVertices*:cint
  maxCommands*:cint
  contextPoolSize*:cint
  pipelinePoolSize*:cint
  colorFormat*:gfx.PixelFormat
  depthFormat*:gfx.PixelFormat
  sampleCount*:cint
  faceWinding*:gfx.FaceWinding
  allocator*:Allocator

proc c_setup(desc:ptr Desc):void {.cdecl, importc:"sgl_setup".}
proc setup*(desc:Desc):void =
    c_setup(unsafeAddr(desc))

proc c_shutdown():void {.cdecl, importc:"sgl_shutdown".}
proc shutdown*():void =
    c_shutdown()

proc c_asRadians(deg:cfloat):cfloat {.cdecl, importc:"sgl_rad".}
proc asRadians*(deg:cfloat):cfloat =
    c_asRadians(deg)

proc c_asDegrees(rad:cfloat):cfloat {.cdecl, importc:"sgl_deg".}
proc asDegrees*(rad:cfloat):cfloat =
    c_asDegrees(rad)

proc c_getError():Error {.cdecl, importc:"sgl_error".}
proc getError*():Error =
    c_getError()

proc c_contextError(ctx:Context):Error {.cdecl, importc:"sgl_context_error".}
proc contextError*(ctx:Context):Error =
    c_contextError(ctx)

proc c_makeContext(desc:ptr ContextDesc):Context {.cdecl, importc:"sgl_make_context".}
proc makeContext*(desc:ContextDesc):Context =
    c_makeContext(unsafeAddr(desc))

proc c_destroyContext(ctx:Context):void {.cdecl, importc:"sgl_destroy_context".}
proc destroyContext*(ctx:Context):void =
    c_destroyContext(ctx)

proc c_setContext(ctx:Context):void {.cdecl, importc:"sgl_set_context".}
proc setContext*(ctx:Context):void =
    c_setContext(ctx)

proc c_getContext():Context {.cdecl, importc:"sgl_get_context".}
proc getContext*():Context =
    c_getContext()

proc c_defaultContext():Context {.cdecl, importc:"sgl_default_context".}
proc defaultContext*():Context =
    c_defaultContext()

proc c_makePipeline(desc:ptr gfx.PipelineDesc):Pipeline {.cdecl, importc:"sgl_make_pipeline".}
proc makePipeline*(desc:gfx.PipelineDesc):Pipeline =
    c_makePipeline(unsafeAddr(desc))

proc c_contextMakePipeline(ctx:Context, desc:ptr gfx.PipelineDesc):Pipeline {.cdecl, importc:"sgl_context_make_pipeline".}
proc contextMakePipeline*(ctx:Context, desc:gfx.PipelineDesc):Pipeline =
    c_contextMakePipeline(ctx, unsafeAddr(desc))

proc c_destroyPipeline(pip:Pipeline):void {.cdecl, importc:"sgl_destroy_pipeline".}
proc destroyPipeline*(pip:Pipeline):void =
    c_destroyPipeline(pip)

proc c_defaults():void {.cdecl, importc:"sgl_defaults".}
proc defaults*():void =
    c_defaults()

proc c_viewport(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void {.cdecl, importc:"sgl_viewport".}
proc viewport*(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void =
    c_viewport(x, y, w, h, origin_top_left)

proc c_viewportf(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void {.cdecl, importc:"sgl_viewportf".}
proc viewportf*(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void =
    c_viewportf(x, y, w, h, origin_top_left)

proc c_scissorRect(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rect".}
proc scissorRect*(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void =
    c_scissorRect(x, y, w, h, origin_top_left)

proc c_scissorRectf(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rectf".}
proc scissorRectf*(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void =
    c_scissorRectf(x, y, w, h, origin_top_left)

proc c_enableTexture():void {.cdecl, importc:"sgl_enable_texture".}
proc enableTexture*():void =
    c_enableTexture()

proc c_disableTexture():void {.cdecl, importc:"sgl_disable_texture".}
proc disableTexture*():void =
    c_disableTexture()

proc c_texture(img:gfx.Image):void {.cdecl, importc:"sgl_texture".}
proc texture*(img:gfx.Image):void =
    c_texture(img)

proc c_loadDefaultPipeline():void {.cdecl, importc:"sgl_load_default_pipeline".}
proc loadDefaultPipeline*():void =
    c_loadDefaultPipeline()

proc c_loadPipeline(pip:Pipeline):void {.cdecl, importc:"sgl_load_pipeline".}
proc loadPipeline*(pip:Pipeline):void =
    c_loadPipeline(pip)

proc c_pushPipeline():void {.cdecl, importc:"sgl_push_pipeline".}
proc pushPipeline*():void =
    c_pushPipeline()

proc c_popPipeline():void {.cdecl, importc:"sgl_pop_pipeline".}
proc popPipeline*():void =
    c_popPipeline()

proc c_matrixModeModelview():void {.cdecl, importc:"sgl_matrix_mode_modelview".}
proc matrixModeModelview*():void =
    c_matrixModeModelview()

proc c_matrixModeProjection():void {.cdecl, importc:"sgl_matrix_mode_projection".}
proc matrixModeProjection*():void =
    c_matrixModeProjection()

proc c_matrixModeTexture():void {.cdecl, importc:"sgl_matrix_mode_texture".}
proc matrixModeTexture*():void =
    c_matrixModeTexture()

proc c_loadIdentity():void {.cdecl, importc:"sgl_load_identity".}
proc loadIdentity*():void =
    c_loadIdentity()

proc c_loadMatrix(m:ptr cfloat):void {.cdecl, importc:"sgl_load_matrix".}
proc loadMatrix*(m:ptr cfloat):void =
    c_loadMatrix(m)

proc c_loadTransposeMatrix(m:ptr cfloat):void {.cdecl, importc:"sgl_load_transpose_matrix".}
proc loadTransposeMatrix*(m:ptr cfloat):void =
    c_loadTransposeMatrix(m)

proc c_multMatrix(m:ptr cfloat):void {.cdecl, importc:"sgl_mult_matrix".}
proc multMatrix*(m:ptr cfloat):void =
    c_multMatrix(m)

proc c_multTransposeMatrix(m:ptr cfloat):void {.cdecl, importc:"sgl_mult_transpose_matrix".}
proc multTransposeMatrix*(m:ptr cfloat):void =
    c_multTransposeMatrix(m)

proc c_rotate(angle_rad:cfloat, x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_rotate".}
proc rotate*(angle_rad:cfloat, x:cfloat, y:cfloat, z:cfloat):void =
    c_rotate(angle_rad, x, y, z)

proc c_scale(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_scale".}
proc scale*(x:cfloat, y:cfloat, z:cfloat):void =
    c_scale(x, y, z)

proc c_translate(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_translate".}
proc translate*(x:cfloat, y:cfloat, z:cfloat):void =
    c_translate(x, y, z)

proc c_frustum(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void {.cdecl, importc:"sgl_frustum".}
proc frustum*(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void =
    c_frustum(l, r, b, t, n, f)

proc c_ortho(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void {.cdecl, importc:"sgl_ortho".}
proc ortho*(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void =
    c_ortho(l, r, b, t, n, f)

proc c_perspective(fov_y:cfloat, aspect:cfloat, z_near:cfloat, z_far:cfloat):void {.cdecl, importc:"sgl_perspective".}
proc perspective*(fov_y:cfloat, aspect:cfloat, z_near:cfloat, z_far:cfloat):void =
    c_perspective(fov_y, aspect, z_near, z_far)

proc c_lookat(eye_x:cfloat, eye_y:cfloat, eye_z:cfloat, center_x:cfloat, center_y:cfloat, center_z:cfloat, up_x:cfloat, up_y:cfloat, up_z:cfloat):void {.cdecl, importc:"sgl_lookat".}
proc lookat*(eye_x:cfloat, eye_y:cfloat, eye_z:cfloat, center_x:cfloat, center_y:cfloat, center_z:cfloat, up_x:cfloat, up_y:cfloat, up_z:cfloat):void =
    c_lookat(eye_x, eye_y, eye_z, center_x, center_y, center_z, up_x, up_y, up_z)

proc c_pushMatrix():void {.cdecl, importc:"sgl_push_matrix".}
proc pushMatrix*():void =
    c_pushMatrix()

proc c_popMatrix():void {.cdecl, importc:"sgl_pop_matrix".}
proc popMatrix*():void =
    c_popMatrix()

proc c_t2f(u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_t2f".}
proc t2f*(u:cfloat, v:cfloat):void =
    c_t2f(u, v)

proc c_c3f(r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_c3f".}
proc c3f*(r:cfloat, g:cfloat, b:cfloat):void =
    c_c3f(r, g, b)

proc c_c4f(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_c4f".}
proc c4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_c4f(r, g, b, a)

proc c_c3b(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_c3b".}
proc c3b*(r:uint8, g:uint8, b:uint8):void =
    c_c3b(r, g, b)

proc c_c4b(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_c4b".}
proc c4b*(r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_c4b(r, g, b, a)

proc c_c1i(rgba:uint32):void {.cdecl, importc:"sgl_c1i".}
proc c1i*(rgba:uint32):void =
    c_c1i(rgba)

proc c_pointSize(s:cfloat):void {.cdecl, importc:"sgl_point_size".}
proc pointSize*(s:cfloat):void =
    c_pointSize(s)

proc c_beginPoints():void {.cdecl, importc:"sgl_begin_points".}
proc beginPoints*():void =
    c_beginPoints()

proc c_beginLines():void {.cdecl, importc:"sgl_begin_lines".}
proc beginLines*():void =
    c_beginLines()

proc c_beginLineStrip():void {.cdecl, importc:"sgl_begin_line_strip".}
proc beginLineStrip*():void =
    c_beginLineStrip()

proc c_beginTriangles():void {.cdecl, importc:"sgl_begin_triangles".}
proc beginTriangles*():void =
    c_beginTriangles()

proc c_beginTriangleStrip():void {.cdecl, importc:"sgl_begin_triangle_strip".}
proc beginTriangleStrip*():void =
    c_beginTriangleStrip()

proc c_beginQuads():void {.cdecl, importc:"sgl_begin_quads".}
proc beginQuads*():void =
    c_beginQuads()

proc c_v2f(x:cfloat, y:cfloat):void {.cdecl, importc:"sgl_v2f".}
proc v2f*(x:cfloat, y:cfloat):void =
    c_v2f(x, y)

proc c_v3f(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_v3f".}
proc v3f*(x:cfloat, y:cfloat, z:cfloat):void =
    c_v3f(x, y, z)

proc c_v2fT2f(x:cfloat, y:cfloat, u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_v2f_t2f".}
proc v2fT2f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat):void =
    c_v2fT2f(x, y, u, v)

proc c_v3fT2f(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_v3f_t2f".}
proc v3fT2f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat):void =
    c_v3fT2f(x, y, z, u, v)

proc c_v2fC3f(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v2f_c3f".}
proc v2fC3f*(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat):void =
    c_v2fC3f(x, y, r, g, b)

proc c_v2fC3b(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_c3b".}
proc v2fC3b*(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8):void =
    c_v2fC3b(x, y, r, g, b)

proc c_v2fC4f(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v2f_c4f".}
proc v2fC4f*(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_v2fC4f(x, y, r, g, b, a)

proc c_v2fC4b(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_c4b".}
proc v2fC4b*(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_v2fC4b(x, y, r, g, b, a)

proc c_v2fC1i(x:cfloat, y:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v2f_c1i".}
proc v2fC1i*(x:cfloat, y:cfloat, rgba:uint32):void =
    c_v2fC1i(x, y, rgba)

proc c_v3fC3f(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v3f_c3f".}
proc v3fC3f*(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat):void =
    c_v3fC3f(x, y, z, r, g, b)

proc c_v3fC3b(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_c3b".}
proc v3fC3b*(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8):void =
    c_v3fC3b(x, y, z, r, g, b)

proc c_v3fC4f(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v3f_c4f".}
proc v3fC4f*(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_v3fC4f(x, y, z, r, g, b, a)

proc c_v3fC4b(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_c4b".}
proc v3fC4b*(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_v3fC4b(x, y, z, r, g, b, a)

proc c_v3fC1i(x:cfloat, y:cfloat, z:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v3f_c1i".}
proc v3fC1i*(x:cfloat, y:cfloat, z:cfloat, rgba:uint32):void =
    c_v3fC1i(x, y, z, rgba)

proc c_v2fT2fC3f(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v2f_t2f_c3f".}
proc v2fT2fC3f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void =
    c_v2fT2fC3f(x, y, u, v, r, g, b)

proc c_v2fT2fC3b(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c3b".}
proc v2fT2fC3b*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void =
    c_v2fT2fC3b(x, y, u, v, r, g, b)

proc c_v2fT2fC4f(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v2f_t2f_c4f".}
proc v2fT2fC4f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_v2fT2fC4f(x, y, u, v, r, g, b, a)

proc c_v2fT2fC4b(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c4b".}
proc v2fT2fC4b*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_v2fT2fC4b(x, y, u, v, r, g, b, a)

proc c_v2fT2fC1i(x:cfloat, y:cfloat, u:cfloat, v:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v2f_t2f_c1i".}
proc v2fT2fC1i*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, rgba:uint32):void =
    c_v2fT2fC1i(x, y, u, v, rgba)

proc c_v3fT2fC3f(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v3f_t2f_c3f".}
proc v3fT2fC3f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void =
    c_v3fT2fC3f(x, y, z, u, v, r, g, b)

proc c_v3fT2fC3b(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c3b".}
proc v3fT2fC3b*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void =
    c_v3fT2fC3b(x, y, z, u, v, r, g, b)

proc c_v3fT2fC4f(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v3f_t2f_c4f".}
proc v3fT2fC4f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void =
    c_v3fT2fC4f(x, y, z, u, v, r, g, b, a)

proc c_v3fT2fC4b(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c4b".}
proc v3fT2fC4b*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void =
    c_v3fT2fC4b(x, y, z, u, v, r, g, b, a)

proc c_v3fT2fC1i(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v3f_t2f_c1i".}
proc v3fT2fC1i*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, rgba:uint32):void =
    c_v3fT2fC1i(x, y, z, u, v, rgba)

proc c_`end`():void {.cdecl, importc:"sgl_end".}
proc `end`*():void =
    c_`end`()

proc c_draw():void {.cdecl, importc:"sgl_draw".}
proc draw*():void =
    c_draw()

proc c_contextDraw(ctx:Context):void {.cdecl, importc:"sgl_context_draw".}
proc contextDraw*(ctx:Context):void =
    c_contextDraw(ctx)

{.passc:"-DSOKOL_NIM_IMPL".}
{.compile:"c/sokol_gl.c".}
