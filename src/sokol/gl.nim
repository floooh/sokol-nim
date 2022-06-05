## machine generated, do not edit

import gfx

type Pipeline* = object
  id*:uint32

type Context* = object
  id*:uint32

type
  Error* {.pure, size:sizeof(cint).} = enum
    error = 0,
    verticesFull = 1,
    uniformsFull = 2,
    commandsFull = 3,
    stackOverflow = 4,
    stackUnderflow = 5,
    noContext = 6,

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

proc setup*(desc:ptr Desc):void {.cdecl, importc:"sgl_setup".}

proc shutdown*():void {.cdecl, importc:"sgl_shutdown".}

proc asRadians*(deg:cfloat):cfloat {.cdecl, importc:"sgl_rad".}

proc asDegrees*(rad:cfloat):cfloat {.cdecl, importc:"sgl_deg".}

proc getError*():Error {.cdecl, importc:"sgl_error".}

proc contextError*(ctx:Context):Error {.cdecl, importc:"sgl_context_error".}

proc makeContext*(desc:ptr ContextDesc):Context {.cdecl, importc:"sgl_make_context".}

proc destroyContext*(ctx:Context):void {.cdecl, importc:"sgl_destroy_context".}

proc setContext*(ctx:Context):void {.cdecl, importc:"sgl_set_context".}

proc getContext*():Context {.cdecl, importc:"sgl_get_context".}

proc defaultContext*():Context {.cdecl, importc:"sgl_default_context".}

proc makePipeline*(desc:ptr gfx.PipelineDesc):Pipeline {.cdecl, importc:"sgl_make_pipeline".}

proc contextMakePipeline*(ctx:Context, desc:ptr gfx.PipelineDesc):Pipeline {.cdecl, importc:"sgl_context_make_pipeline".}

proc destroyPipeline*(pip:Pipeline):void {.cdecl, importc:"sgl_destroy_pipeline".}

proc defaults*():void {.cdecl, importc:"sgl_defaults".}

proc viewport*(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void {.cdecl, importc:"sgl_viewport".}

proc viewportf*(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void {.cdecl, importc:"sgl_viewportf".}

proc scissorRect*(x:cint, y:cint, w:cint, h:cint, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rect".}

proc scissorRectf*(x:cfloat, y:cfloat, w:cfloat, h:cfloat, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rectf".}

proc enableTexture*():void {.cdecl, importc:"sgl_enable_texture".}

proc disableTexture*():void {.cdecl, importc:"sgl_disable_texture".}

proc texture*(img:gfx.Image):void {.cdecl, importc:"sgl_texture".}

proc loadDefaultPipeline*():void {.cdecl, importc:"sgl_load_default_pipeline".}

proc loadPipeline*(pip:Pipeline):void {.cdecl, importc:"sgl_load_pipeline".}

proc pushPipeline*():void {.cdecl, importc:"sgl_push_pipeline".}

proc popPipeline*():void {.cdecl, importc:"sgl_pop_pipeline".}

proc matrixModeModelview*():void {.cdecl, importc:"sgl_matrix_mode_modelview".}

proc matrixModeProjection*():void {.cdecl, importc:"sgl_matrix_mode_projection".}

proc matrixModeTexture*():void {.cdecl, importc:"sgl_matrix_mode_texture".}

proc loadIdentity*():void {.cdecl, importc:"sgl_load_identity".}

proc loadMatrix*(m:ptr cfloat):void {.cdecl, importc:"sgl_load_matrix".}

proc loadTransposeMatrix*(m:ptr cfloat):void {.cdecl, importc:"sgl_load_transpose_matrix".}

proc multMatrix*(m:ptr cfloat):void {.cdecl, importc:"sgl_mult_matrix".}

proc multTransposeMatrix*(m:ptr cfloat):void {.cdecl, importc:"sgl_mult_transpose_matrix".}

proc rotate*(angle_rad:cfloat, x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_rotate".}

proc scale*(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_scale".}

proc translate*(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_translate".}

proc frustum*(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void {.cdecl, importc:"sgl_frustum".}

proc ortho*(l:cfloat, r:cfloat, b:cfloat, t:cfloat, n:cfloat, f:cfloat):void {.cdecl, importc:"sgl_ortho".}

proc perspective*(fov_y:cfloat, aspect:cfloat, z_near:cfloat, z_far:cfloat):void {.cdecl, importc:"sgl_perspective".}

proc lookat*(eye_x:cfloat, eye_y:cfloat, eye_z:cfloat, center_x:cfloat, center_y:cfloat, center_z:cfloat, up_x:cfloat, up_y:cfloat, up_z:cfloat):void {.cdecl, importc:"sgl_lookat".}

proc pushMatrix*():void {.cdecl, importc:"sgl_push_matrix".}

proc popMatrix*():void {.cdecl, importc:"sgl_pop_matrix".}

proc t2f*(u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_t2f".}

proc c3f*(r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_c3f".}

proc c4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_c4f".}

proc c3b*(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_c3b".}

proc c4b*(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_c4b".}

proc c1i*(rgba:uint32):void {.cdecl, importc:"sgl_c1i".}

proc pointSize*(s:cfloat):void {.cdecl, importc:"sgl_point_size".}

proc beginPoints*():void {.cdecl, importc:"sgl_begin_points".}

proc beginLines*():void {.cdecl, importc:"sgl_begin_lines".}

proc beginLineStrip*():void {.cdecl, importc:"sgl_begin_line_strip".}

proc beginTriangles*():void {.cdecl, importc:"sgl_begin_triangles".}

proc beginTriangleStrip*():void {.cdecl, importc:"sgl_begin_triangle_strip".}

proc beginQuads*():void {.cdecl, importc:"sgl_begin_quads".}

proc v2f*(x:cfloat, y:cfloat):void {.cdecl, importc:"sgl_v2f".}

proc v3f*(x:cfloat, y:cfloat, z:cfloat):void {.cdecl, importc:"sgl_v3f".}

proc v2fT2f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_v2f_t2f".}

proc v3fT2f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat):void {.cdecl, importc:"sgl_v3f_t2f".}

proc v2fC3f*(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v2f_c3f".}

proc v2fC3b*(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_c3b".}

proc v2fC4f*(x:cfloat, y:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v2f_c4f".}

proc v2fC4b*(x:cfloat, y:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_c4b".}

proc v2fC1i*(x:cfloat, y:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v2f_c1i".}

proc v3fC3f*(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v3f_c3f".}

proc v3fC3b*(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_c3b".}

proc v3fC4f*(x:cfloat, y:cfloat, z:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v3f_c4f".}

proc v3fC4b*(x:cfloat, y:cfloat, z:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_c4b".}

proc v3fC1i*(x:cfloat, y:cfloat, z:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v3f_c1i".}

proc v2fT2fC3f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v2f_t2f_c3f".}

proc v2fT2fC3b*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c3b".}

proc v2fT2fC4f*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v2f_t2f_c4f".}

proc v2fT2fC4b*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c4b".}

proc v2fT2fC1i*(x:cfloat, y:cfloat, u:cfloat, v:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v2f_t2f_c1i".}

proc v3fT2fC3f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat):void {.cdecl, importc:"sgl_v3f_t2f_c3f".}

proc v3fT2fC3b*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c3b".}

proc v3fT2fC4f*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:cfloat, g:cfloat, b:cfloat, a:cfloat):void {.cdecl, importc:"sgl_v3f_t2f_c4f".}

proc v3fT2fC4b*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c4b".}

proc v3fT2fC1i*(x:cfloat, y:cfloat, z:cfloat, u:cfloat, v:cfloat, rgba:uint32):void {.cdecl, importc:"sgl_v3f_t2f_c1i".}

proc `end`*():void {.cdecl, importc:"sgl_end".}

proc draw*():void {.cdecl, importc:"sgl_draw".}

proc contextDraw*(ctx:Context):void {.cdecl, importc:"sgl_context_draw".}

# Nim-specific API extensions
include extra/gl
