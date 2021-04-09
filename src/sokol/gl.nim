## machine generated, do not edit

import gfx

type Pipeline* = object
  id*:uint32

type Error* {.pure.} = enum
  Error = 0,
  VerticesFull = 1,
  UniformsFull = 2,
  CommandsFull = 3,
  StackOverflow = 4,
  StackUnderflow = 5,

type Desc* = object
  maxVertices*:int32
  maxCommands*:int32
  pipelinePoolSize*:int32
  colorFormat*:sg.PixelFormat
  depthFormat*:sg.PixelFormat
  sampleCount*:int32
  faceWinding*:sg.FaceWinding

proc setup*(desc:ptr Desc):void {.cdecl, importc:"sgl_setup".}

proc shutdown*():void {.cdecl, importc:"sgl_shutdown".}

proc error*():Error {.cdecl, importc:"sgl_error".}

proc defaults*():void {.cdecl, importc:"sgl_defaults".}

proc rad*(deg:float32):float32 {.cdecl, importc:"sgl_rad".}

proc deg*(rad:float32):float32 {.cdecl, importc:"sgl_deg".}

proc makePipeline*(desc:ptr sg.PipelineDesc):Pipeline {.cdecl, importc:"sgl_make_pipeline".}

proc destroyPipeline*(pip:Pipeline):void {.cdecl, importc:"sgl_destroy_pipeline".}

proc viewport*(x:int32, y:int32, w:int32, h:int32, origin_top_left:bool):void {.cdecl, importc:"sgl_viewport".}

proc viewportf*(x:float32, y:float32, w:float32, h:float32, origin_top_left:bool):void {.cdecl, importc:"sgl_viewportf".}

proc scissorRect*(x:int32, y:int32, w:int32, h:int32, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rect".}

proc scissorRectf*(x:float32, y:float32, w:float32, h:float32, origin_top_left:bool):void {.cdecl, importc:"sgl_scissor_rectf".}

proc enableTexture*():void {.cdecl, importc:"sgl_enable_texture".}

proc disableTexture*():void {.cdecl, importc:"sgl_disable_texture".}

proc texture*(img:sg.Image):void {.cdecl, importc:"sgl_texture".}

proc defaultPipeline*():void {.cdecl, importc:"sgl_default_pipeline".}

proc loadPipeline*(pip:Pipeline):void {.cdecl, importc:"sgl_load_pipeline".}

proc pushPipeline*():void {.cdecl, importc:"sgl_push_pipeline".}

proc popPipeline*():void {.cdecl, importc:"sgl_pop_pipeline".}

proc matrixModeModelview*():void {.cdecl, importc:"sgl_matrix_mode_modelview".}

proc matrixModeProjection*():void {.cdecl, importc:"sgl_matrix_mode_projection".}

proc matrixModeTexture*():void {.cdecl, importc:"sgl_matrix_mode_texture".}

proc loadIdentity*():void {.cdecl, importc:"sgl_load_identity".}

proc loadMatrix*(m:ptr float32):void {.cdecl, importc:"sgl_load_matrix".}

proc loadTransposeMatrix*(m:ptr float32):void {.cdecl, importc:"sgl_load_transpose_matrix".}

proc multMatrix*(m:ptr float32):void {.cdecl, importc:"sgl_mult_matrix".}

proc multTransposeMatrix*(m:ptr float32):void {.cdecl, importc:"sgl_mult_transpose_matrix".}

proc rotate*(angle_rad:float32, x:float32, y:float32, z:float32):void {.cdecl, importc:"sgl_rotate".}

proc scale*(x:float32, y:float32, z:float32):void {.cdecl, importc:"sgl_scale".}

proc translate*(x:float32, y:float32, z:float32):void {.cdecl, importc:"sgl_translate".}

proc frustum*(l:float32, r:float32, b:float32, t:float32, n:float32, f:float32):void {.cdecl, importc:"sgl_frustum".}

proc ortho*(l:float32, r:float32, b:float32, t:float32, n:float32, f:float32):void {.cdecl, importc:"sgl_ortho".}

proc perspective*(fov_y:float32, aspect:float32, z_near:float32, z_far:float32):void {.cdecl, importc:"sgl_perspective".}

proc lookat*(eye_x:float32, eye_y:float32, eye_z:float32, center_x:float32, center_y:float32, center_z:float32, up_x:float32, up_y:float32, up_z:float32):void {.cdecl, importc:"sgl_lookat".}

proc pushMatrix*():void {.cdecl, importc:"sgl_push_matrix".}

proc popMatrix*():void {.cdecl, importc:"sgl_pop_matrix".}

proc t2f*(u:float32, v:float32):void {.cdecl, importc:"sgl_t2f".}

proc c3f*(r:float32, g:float32, b:float32):void {.cdecl, importc:"sgl_c3f".}

proc c4f*(r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sgl_c4f".}

proc c3b*(r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_c3b".}

proc c4b*(r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_c4b".}

proc c1i*(rgba:uint32):void {.cdecl, importc:"sgl_c1i".}

proc beginPoints*():void {.cdecl, importc:"sgl_begin_points".}

proc beginLines*():void {.cdecl, importc:"sgl_begin_lines".}

proc beginLineStrip*():void {.cdecl, importc:"sgl_begin_line_strip".}

proc beginTriangles*():void {.cdecl, importc:"sgl_begin_triangles".}

proc beginTriangleStrip*():void {.cdecl, importc:"sgl_begin_triangle_strip".}

proc beginQuads*():void {.cdecl, importc:"sgl_begin_quads".}

proc v2f*(x:float32, y:float32):void {.cdecl, importc:"sgl_v2f".}

proc v3f*(x:float32, y:float32, z:float32):void {.cdecl, importc:"sgl_v3f".}

proc v2fT2f*(x:float32, y:float32, u:float32, v:float32):void {.cdecl, importc:"sgl_v2f_t2f".}

proc v3fT2f*(x:float32, y:float32, z:float32, u:float32, v:float32):void {.cdecl, importc:"sgl_v3f_t2f".}

proc v2fC3f*(x:float32, y:float32, r:float32, g:float32, b:float32):void {.cdecl, importc:"sgl_v2f_c3f".}

proc v2fC3b*(x:float32, y:float32, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_c3b".}

proc v2fC4f*(x:float32, y:float32, r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sgl_v2f_c4f".}

proc v2fC4b*(x:float32, y:float32, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_c4b".}

proc v2fC1i*(x:float32, y:float32, rgba:uint32):void {.cdecl, importc:"sgl_v2f_c1i".}

proc v3fC3f*(x:float32, y:float32, z:float32, r:float32, g:float32, b:float32):void {.cdecl, importc:"sgl_v3f_c3f".}

proc v3fC3b*(x:float32, y:float32, z:float32, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_c3b".}

proc v3fC4f*(x:float32, y:float32, z:float32, r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sgl_v3f_c4f".}

proc v3fC4b*(x:float32, y:float32, z:float32, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_c4b".}

proc v3fC1i*(x:float32, y:float32, z:float32, rgba:uint32):void {.cdecl, importc:"sgl_v3f_c1i".}

proc v2fT2fC3f*(x:float32, y:float32, u:float32, v:float32, r:float32, g:float32, b:float32):void {.cdecl, importc:"sgl_v2f_t2f_c3f".}

proc v2fT2fC3b*(x:float32, y:float32, u:float32, v:float32, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c3b".}

proc v2fT2fC4f*(x:float32, y:float32, u:float32, v:float32, r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sgl_v2f_t2f_c4f".}

proc v2fT2fC4b*(x:float32, y:float32, u:float32, v:float32, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v2f_t2f_c4b".}

proc v2fT2fC1i*(x:float32, y:float32, u:float32, v:float32, rgba:uint32):void {.cdecl, importc:"sgl_v2f_t2f_c1i".}

proc v3fT2fC3f*(x:float32, y:float32, z:float32, u:float32, v:float32, r:float32, g:float32, b:float32):void {.cdecl, importc:"sgl_v3f_t2f_c3f".}

proc v3fT2fC3b*(x:float32, y:float32, z:float32, u:float32, v:float32, r:uint8, g:uint8, b:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c3b".}

proc v3fT2fC4f*(x:float32, y:float32, z:float32, u:float32, v:float32, r:float32, g:float32, b:float32, a:float32):void {.cdecl, importc:"sgl_v3f_t2f_c4f".}

proc v3fT2fC4b*(x:float32, y:float32, z:float32, u:float32, v:float32, r:uint8, g:uint8, b:uint8, a:uint8):void {.cdecl, importc:"sgl_v3f_t2f_c4b".}

proc v3fT2fC1i*(x:float32, y:float32, z:float32, u:float32, v:float32, rgba:uint32):void {.cdecl, importc:"sgl_v3f_t2f_c1i".}

proc end*():void {.cdecl, importc:"sgl_end".}

proc draw*():void {.cdecl, importc:"sgl_draw".}

# Nim-specific API extensions
include nim/gl
