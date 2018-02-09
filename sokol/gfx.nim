{.deadCodeElim: on.}
{.compile: "native/sokol.c".}
{.passL: "-framework OpenGL -framework Foundation".}
## 
##     sokol_gfx.h -- simple 3D API wrapper
## 
##     Do this:
##         #define SOKOL_IMPL
##     before you include this file in *one* C or C++ file to create the 
##     implementation.
## 
##     In the same place define one of the following to select the rendering
##     backend:
##         #define SOKOL_GLCORE33
##         #define SOKOL_GLES2
##         #define SOKOL_GLES3
##         #define SOKOL_D3D11
##         #define SOKOL_METAL_MACOS
##         #define SOKOL_METAL_IOS
## 
##     I.e. for the GL 3.3 Core Profile it should look like this:
## 
##     #include ...
##     #include ...
##     #define SOKOL_IMPL
##     #define SOKOL_GLCORE33
##     #include "sokol_gfx.h"
## 
##     To enable shader compilation support in the D3D11 backend:
##         #define SOKOL_D3D11_SHADER_COMPILER
## 
##     If SOKOL_D3D11_SHADER_COMPILER is enabled, the executable will link against 
##     d3dcompiler.lib (d3dcompiler_47.dll).
## 
##     Optionally provide the following defines with your own implementations:
## 
##     SOKOL_ASSERT(c)     - your own assert macro (default: assert(c))
##     SOKOL_MALLOC(s)     - your own malloc function (default: malloc(s))
##     SOKOL_FREE(p)       - your own free function (default: free(p))
##     SOKOL_LOG(msg)      - your own logging function (default: puts(msg))
##     SOKOL_UNREACHABLE() - a guard macro for unreachable code (default: assert(false))
## 
##     API usage validation macros:
## 
##     SOKOL_VALIDATE_BEGIN()      - begin a validation block (default:_sg_validate_begin())
##     SOKOL_VALIDATE(cond, err)   - like assert but for API validation (default: _sg_validate(cond, err)) 
##     SOKOL_VALIDATE_END()        - end a validation block, return true if all checks in block passed (default: bool _sg_validate())
## 
##     If you don't want validation errors to be fatal, define SOKOL_VALIDATE_NON_FATAL,
##     be aware though that this may spam SOKOL_LOG messages.
## 
##     Optionally define the following to force debug checks and validations
##     even in release mode:
## 
##     SOKOL_DEBUG         - by default this is defined if _DEBUG is defined
## 
## 
##     sokol_gfx DOES NOT:
##     ===================
##     - create a window or the 3D-API context/device, you must do this
##       before sokol_gfx is initialized, and pass any required information
##       (like 3D device pointers) to the sokol_gfx initialization call
## 
##     - present the rendered frame, how this is done exactly usually depends
##       on how the window and 3D-API context/device was created
## 
##     - provide a unified shader language, instead 3D-API-specific shader
##       source-code or shader-bytecode must be provided
## 
##     For complete code examples using the various backend 3D-APIs, see:
## 
##         https://github.com/floooh/sokol-samples
## 
## 
##     STEP BY STEP
##     ============
##     --- to initialize sokol_gfx, after creating a window and a 3D-API 
##         context/device, call:
## 
##             sg_setup(const sg_desc*) 
## 
##     --- create resource objects (at least buffers, shaders and pipelines,
##         and optionally images and passes):
## 
##             sg_buffer sg_make_buffer(const sg_buffer_desc*)
##             sg_image sg_make_image(const sg_image_desc*)
##             sg_shader sg_make_shader(const sg_shader_desc*)
##             sg_pipeline sg_make_pipeline(const sg_pipeline_desc*)
##             sg_pass sg_make_pass(const sg_pass_desc*)
## 
##     --- start rendering to the default frame buffer with:
## 
##             sg_begin_default_pass(const sg_pass_action* actions, int width, int height)
## 
##     --- or start rendering to an offscreen framebuffer with:
## 
##             sg_begin_pass(sg_pass pass, const sg_pass_action* actions)
## 
##     --- fill an sg_draw_state struct with the resource bindings for the next 
##         draw call (one pipeline object, 1..N vertex buffers, 0 or 1
##         index buffer, 0..N image objects to use as textures each on 
##         the vertex-shader- and fragment-shader-stage and then call
##             
##             sg_apply_draw_state(const sg_draw_state* draw_state)
## 
##         to update the resource bindings
## 
##     --- optionally update shader uniform data with:
## 
##             sg_apply_uniform_block(sg_shader_stage stage, int ub_index, const void* data, int num_bytes)
## 
##     --- kick off a draw call with:
##     
##             sg_draw(int base_element, int num_elements, int num_instances)
## 
##     --- finish the current rendering pass with:
##             
##             sg_end_pass()
## 
##     --- when done with the current frame, call
## 
##             sg_commit()
## 
##     --- at the end of your program, shutdown sokol_gfx with:
## 
##             sg_shutdown()
##     
##     --- if you need to destroy resources before sg_shutdown(), call:
## 
##             sg_destroy_buffer(sg_buffer buf)
##             sg_destroy_image(sg_image img)
##             sg_destroy_shader(sg_shader shd)
##             sg_destroy_pipeline(sg_pipeline pip)
##             sg_destroy_pass(sg_pass pass)
## 
##     --- to set a new viewport rectangle, call
## 
##             sg_apply_viewport(int x, int y, int width, int height, bool origin_top_left)
## 
##     --- to set a new scissor rect, call:
## 
##             sg_apply_scissor_rect(int x, int y, int width, int height, bool origin_top_left)
## 
##         both sg_apply_viewport() and sg_apply_scissor_rect() must be called
##         inside a rendering pass
##         
##         beginning a pass will reset the viewport to the size of the framebuffer used 
##         in the new pass, 
## 
##     --- to update the content of buffer and image resources, call:
## 
##             sg_update_buffer(sg_buffer buf, const void* ptr, int num_bytes)
##             sg_update_image(sg_image img, const sg_image_content* content)
##         
##         buffers and images to be updated must have been created with 
##         SG_USAGE_DYNAMIC or SG_USAGE_STREAM
##         
##     --- to check for support of optional features:
##         
##             bool sg_query_feature(sg_feature feature)
## 
##     --- if you need to call into the underlying 3D-API directly, you must call:
## 
##             sg_reset_state_cache()
## 
##         ...before calling sokol_gfx functions again
## 
##     BACKEND-SPECIFIC TOPICS:
##     ========================
##     --- the GL backends need to know about the internal structure of uniform 
##         blocks, and the texture sampler-name and -type:
## 
##             typedef struct {
##                 float mvp[16];      // model-view-projection matrix
##                 float offset0[2];   // some 2D vectors
##                 float offset1[2];
##                 float offset2[2];
##             } params_t;
##              
##             // uniform block structure and texture image definition in sg_shader_desc:
##             sg_shader_desc desc = {
##                 // uniform block description (size and internal structure)
##                 .vs.uniform_blocks[0] = {
##                     .size = sizeof(params_t),
##                     .uniforms = {
##                         [0] = { .name="mvp", .type=SG_UNIFORMTYPE_MAT4 },
##                         [1] = { .name="offset0", .type=SG_UNIFORMTYPE_VEC2 },
##                         ...
##                     }
##                 },
##                 // one texture on the fragment-shader-stage, GLES2/WebGL needs name and image type
##                 .fs.images[0] = { .name="tex", .type=SG_IMAGETYPE_ARRAY }
##                 ...
##             };
## 
##     --- the Metal and D3D11 backends only need to know the size of uniform blocks, 
##         not their internal member structure, and they only need to know
##         the type of a texture sampler, not its name:
## 
##             sg_shader_desc desc = {
##                 .vs.uniform_blocks[0].size = sizeof(params_t),
##                 .fs.images[0].type = SG_IMAGETYPE_ARRAY,
##                 ...
##             };
## 
##     --- when creating a pipeline object, GLES2/WebGL need to know the vertex
##         attribute names as used in the vertex shader when describing vertex 
##         layouts:
## 
##             sg_pipeline_desc desc = {
##                 .layout = {
##                     .attrs = {
##                         [0] = { .name="position", .format=SG_VERTEXFORMAT_FLOAT3 },
##                         [1] = { .name="color1", .format=SG_VERTEXFORMAT_FLOAT4 }
##                     }
##                 }
##             };
## 
##     --- on D3D11 you need to provide a semantic name and semantic index in the
##         vertex attribute definition instead (see the D3D11 documentation on
##         D3D11_INPUT_ELEMENT_DESC for details):
## 
##             sg_pipeline_desc desc = {
##                 .layout = {
##                     .attrs = {
##                         [0] = { .sem_name="POSITION", .sem_index=0, .format=SG_VERTEXFORMAT_FLOAT3 },
##                         [1] = { .sem_name="COLOR", .sem_index=1, .format=SG_VERTEXFORMAT_FLOAT4 }
##                     }
##                 }
##             };
## 
##     --- on Metal, GL 3.3 or GLES3/WebGL2, you don't need to provide an attribute 
##         name or semantic name, since vertex attributes can be bound by their slot index
##         (this is mandatory in Metal, and optional in GL):
## 
##             sg_pipeline_desc desc = {
##                 .layout = {
##                     .attrs = {
##                         [0] = { .format=SG_VERTEXFORMAT_FLOAT3 },
##                         [1] = { .format=SG_VERTEXFORMAT_FLOAT4 }
##                     }
##                 }
##             };
## 
##     TODO:
##     ====
##     - talk about asynchronous resource creation
##     
##     MIT License
## 
##     Copyright (c) 2017 Andre Weissflog
## 
##     Permission is hereby granted, free of charge, to any person obtaining a copy
##     of this software and associated documentation files (the "Software"), to deal
##     in the Software without restriction, including without limitation the rights
##     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
##     copies of the Software, and to permit persons to whom the Software is
##     furnished to do so, subject to the following conditions:
## 
##     The above copyright notice and this permission notice shall be included in all
##     copies or substantial portions of the Software.
## 
##     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
##     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
##     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
##     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
##     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
##     SOFTWARE.    
## 

##  
##     Resource id typedefs:
## 
##     sg_buffer:      vertex- and index-buffers
##     sg_image:       textures and render targets
##     sg_shader:      vertex- and fragment-shaders, uniform blocks
##     sg_pipeline:    associated shader and vertex-layouts, and render states
##     sg_pass:        a bundle of render targets and actions on them
## 
##     Instead of pointers, resource creation functions return a 32-bit
##     number which uniquely identifies the resource object.
## 
##     The 32-bit resource id is split into a 16-bit pool index in the lower bits, 
##     and a 16-bit 'unique counter' in the upper bits. The index allows fast
##     pool lookups, and combined with the unique-mask it allows to detect
##     'dangling accesses' (trying to use an object which no longer exists, and
##     its pool slot has been reused for a new object)
## 
##     The resource ids are wrapped into a struct so that the compiler
##     can complain when the wrong resource type is used.
## 

type
  sg_buffer* {.bycopy.} = object
    id*: uint32

  sg_image* {.bycopy.} = object
    id*: uint32

  sg_shader* {.bycopy.} = object
    id*: uint32

  sg_pipeline* {.bycopy.} = object
    id*: uint32

  sg_pass* {.bycopy.} = object
    id*: uint32


##  
##     various compile-time constants
## 
##     FIXME: it may make sense to convert some of those into defines so
##     that the user code can override them.
## 

const
  SG_INVALID_ID* = 0
  SG_NUM_SHADER_STAGES* = 2
  SG_NUM_INFLIGHT_FRAMES* = 2
  SG_MAX_COLOR_ATTACHMENTS* = 4
  SG_MAX_SHADERSTAGE_BUFFERS* = 4
  SG_MAX_SHADERSTAGE_IMAGES* = 12
  SG_MAX_SHADERSTAGE_UBS* = 4
  SG_MAX_UB_MEMBERS* = 16
  SG_MAX_VERTEX_ATTRIBUTES* = 16
  SG_MAX_MIPMAPS* = 16
  SG_MAX_TEXTUREARRAY_LAYERS* = 128

## 
##     sg_feature
## 
##     These are optional features, use the function
##     sg_query_feature() to check whether the feature is supported.
## 

type
  sg_feature* = enum
    SG_FEATURE_INSTANCING, SG_FEATURE_TEXTURE_COMPRESSION_DXT,
    SG_FEATURE_TEXTURE_COMPRESSION_PVRTC, SG_FEATURE_TEXTURE_COMPRESSION_ATC,
    SG_FEATURE_TEXTURE_COMPRESSION_ETC2, SG_FEATURE_TEXTURE_FLOAT,
    SG_FEATURE_TEXTURE_HALF_FLOAT, SG_FEATURE_ORIGIN_BOTTOM_LEFT,
    SG_FEATURE_ORIGIN_TOP_LEFT, SG_FEATURE_MSAA_RENDER_TARGETS,
    SG_FEATURE_PACKED_VERTEX_FORMAT_10_2, SG_FEATURE_MULTIPLE_RENDER_TARGET,
    SG_FEATURE_IMAGETYPE_3D, SG_FEATURE_IMAGETYPE_ARRAY, SG_NUM_FEATURES


## 
##     sg_resource_state
## 
##     The current state of a resource in its resource pool.
##     Resources start in the INITIAL state, which means the 
##     pool slot is unoccupied and can be allocated. When a resource is
##     created, first an id is allocated, and the resource pool slot
##     is set to state ALLOC. After allocation, the resource is
##     initialized, which may result in the VALID or FAILED state. The
##     reason why allocation and initialization are separate is because
##     some resource types (e.g. buffers and images) might be asynchronously
##     initialized by the user application. If a resource which is not
##     in the VALID state is attempted to be used for rendering, rendering
##     operations will silently be dropped.
## 
##     The special INVALID state is returned in sg_query_xxx_state() if no
##     resource object exists for the provided resource id.
## 

type
  sg_resource_state* = enum
    SG_RESOURCESTATE_INITIAL, SG_RESOURCESTATE_ALLOC, SG_RESOURCESTATE_VALID,
    SG_RESOURCESTATE_FAILED, SG_RESOURCESTATE_INVALID,
    SG_RESOURCESTATE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_usage
## 
##     A resource usage hint describing the update strategy of
##     buffers and images. This is used in the sg_buffer_desc.usage
##     and sg_image_desc.usage members when creating buffers
##     and images:
## 
##     SG_USAGE_IMMUTABLE:     the resource will never be updated with
##                             new data, instead the data content of the
##                             resource must be provided on creation
##     SG_USAGE_DYNAMIC:       the resource will be updated infrequently
##                             with new data (this could range from "once
##                             after creation", to "quite often but not
##                             every frame")
##     SG_USAGE_STREAM:        the resource will be updated each frame
##                             with new content
## 
##     The rendering backends use this hint to prevent that the
##     CPU needs to wait for the GPU when attempting to update
##     a resource that might be currently accessed by the GPU.
## 
##     Resource content is updated with the function sg_update_buffer() for
##     buffer objects, and sg_update_image() for image objects. Only
##     one update is allowed per frame and resource object. The
##     application must update all data required for rendering (this
##     means that the update data can be smaller than the resource size,
##     if only a part of the overall resource size is used for rendering,
##     you only need to make sure that the data that *is* used is valid.
## 
##     The default usage is SG_USAGE_IMMUTABLE.
## 

type
  sg_usage* = enum
    SG_USAGE_DEFAULT,        ##  value 0 reserved for default-init
    SG_USAGE_IMMUTABLE, SG_USAGE_DYNAMIC, SG_USAGE_STREAM,
    SG_USAGE_NUM,
    SG_USAGE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_buffer_type
## 
##     This indicates whether a buffer contains vertex- or index-data,
##     used in the sg_buffer_desc.type member when creating a buffer.
## 
##     The default value is SG_BUFFERTYPE_VERTEXBUFFER.
## 

type
  sg_buffer_type* = enum
    SG_BUFFERTYPE_DEFAULT,   ##  value 0 reserved for default-init
    SG_BUFFERTYPE_VERTEXBUFFER, SG_BUFFERTYPE_INDEXBUFFER,
    SG_BUFFERTYPE_NUM,
    SG_BUFFERTYPE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_index_type
## 
##     Indicates whether indexed rendering (fetching vertex-indices from an
##     index buffer) is used, and if yes, the index data type (16- or 32-bits).
##     This is used in the sg_pipeline_desc.index_type member when creating a
##     pipeline object.
## 
##     The default index type is SG_INDEXTYPE_NONE.
## 

type
  sg_index_type* = enum
    SG_INDEXTYPE_DEFAULT,    ##  value 0 reserved for default-init
    SG_INDEXTYPE_NONE, SG_INDEXTYPE_UINT16, SG_INDEXTYPE_UINT32,
    SG_INDEXTYPE_NUM,
    SG_INDEXTYPE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_image_type
## 
##     Indicates the basic image type (2D-texture, cubemap, 3D-texture
##     or 2D-array-texture). 3D- and array-textures are not supported
##     on the GLES2/WebGL backend. The image type is used in the
##     sg_image_desc.type member when creating an image.
## 
##     The default image type when creating an image is SG_IMAGETYPE_2D.
## 

type
  sg_image_type* = enum
    SG_IMAGETYPE_DEFAULT,    ##  value 0 reserved for default-init
    SG_IMAGETYPE_2D, SG_IMAGETYPE_CUBE, SG_IMAGETYPE_3D, SG_IMAGETYPE_ARRAY,
    SG_IMAGETYPE_NUM,
    SG_IMAGETYPE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_cube_face
## 
##     The cubemap faces. Use these as indices in the sg_image_desc.content
##     array.
## 

type
  sg_cube_face* = enum
    SG_CUBEFACE_POS_X,
    SG_CUBEFACE_NEG_X, 
    SG_CUBEFACE_POS_Y, 
    SG_CUBEFACE_NEG_Y,
    SG_CUBEFACE_POS_Z,
    SG_CUBEFACE_NEG_Z,
    SG_CUBEFACE_NUM


## 
##     sg_shader_stage
## 
##     There are 2 shader stages: vertex- and fragment-shader-stage.
##     Each shader stage consists of:
## 
##     - one slot for a shader function (provided as source- or byte-code)
##     - SG_MAX_SHADERSTAGE_UBS slots for uniform blocks
##     - SG_MAX_SHADERSTAGE_IMAGES slots for images used as textures by
##       the shader function
## 

type
  sg_shader_stage* = enum
    SG_SHADERSTAGE_VS, SG_SHADERSTAGE_FS
    SG_SHADERSTAGE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_pixel_format
## 
##     This is a common subset of useful and widely supported pixel formats. The
##     pixel format enum is mainly used when creating an image object in the
##     sg_image_desc.pixel_format member.
## 
##     The default pixel format when creating an image is SG_PIXELFORMAT_RGBA8.
## 

type
  sg_pixel_format* = enum
    SG_PIXELFORMAT_DEFAULT,  ##  value 0 reserved for default-init
    SG_PIXELFORMAT_NONE, SG_PIXELFORMAT_RGBA8, SG_PIXELFORMAT_RGB8,
    SG_PIXELFORMAT_RGBA4, SG_PIXELFORMAT_R5G6B5, SG_PIXELFORMAT_R5G5B5A1,
    SG_PIXELFORMAT_R10G10B10A2, SG_PIXELFORMAT_RGBA32F, SG_PIXELFORMAT_RGBA16F,
    SG_PIXELFORMAT_R32F, SG_PIXELFORMAT_R16F, SG_PIXELFORMAT_L8,
    SG_PIXELFORMAT_DXT1, SG_PIXELFORMAT_DXT3, SG_PIXELFORMAT_DXT5,
    SG_PIXELFORMAT_DEPTH, SG_PIXELFORMAT_DEPTHSTENCIL, SG_PIXELFORMAT_PVRTC2_RGB,
    SG_PIXELFORMAT_PVRTC4_RGB, SG_PIXELFORMAT_PVRTC2_RGBA,
    SG_PIXELFORMAT_PVRTC4_RGBA, SG_PIXELFORMAT_ETC2_RGB8,
    SG_PIXELFORMAT_ETC2_SRGB8, 
    SG_PIXELFORMAT_NUM,
    SG_PIXELFORMAT_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_primitive_type
## 
##     This is the common subset of 3D primitive types supported across all 3D
##     APIs. This is used in the sg_pipeline_desc.primitive_type member when
##     creating a pipeline object.
## 
##     The default primitive type is SG_PRIMITIVETYPE_TRIANGLES.
## 

type
  sg_primitive_type* = enum
    SG_PRIMITIVETYPE_DEFAULT, ##  value 0 reserved for default-init
    SG_PRIMITIVETYPE_POINTS, SG_PRIMITIVETYPE_LINES, SG_PRIMITIVETYPE_LINE_STRIP,
    SG_PRIMITIVETYPE_TRIANGLES, SG_PRIMITIVETYPE_TRIANGLE_STRIP,
    SG_PRIMITIVETYPE_NUM,
    SG_PRIMITIVETYPE_FORCE_U32 = 0x7FFFFFFF

## 
##     sg_filter
## 
##     The filtering mode when sampling a texture image. This is
##     used in the sg_image_desc.min_filter and sg_image_desc.mag_filter
##     members when creating an image object.
## 
##     The default filter mode is SG_FILTER_NEAREST.
## 

type
  sg_filter* = enum
    SG_FILTER_DEFAULT,       ##  value 0 reserved for default-init
    SG_FILTER_NEAREST, SG_FILTER_LINEAR, SG_FILTER_NEAREST_MIPMAP_NEAREST,
    SG_FILTER_NEAREST_MIPMAP_LINEAR, SG_FILTER_LINEAR_MIPMAP_NEAREST,
    SG_FILTER_LINEAR_MIPMAP_LINEAR, 
    SG_FILTER_NUM,
    SG_FILTER_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_wrap
## 
##     The texture coordinates wrapping mode when sampling a texture
##     image. This is used in the sg_image_desc.wrap_u, .wrap_v
##     and .wrap_w members when creating an image.
## 
##     The default wrap mode is SG_WRAP_REPEAT.
## 

type
  sg_wrap* = enum
    SG_WRAP_DEFAULT,         ##  value 0 reserved for default-init
    SG_WRAP_REPEAT, SG_WRAP_CLAMP_TO_EDGE, SG_WRAP_MIRRORED_REPEAT, 
    SG_WRAP_NUM,
    SG_WRAP_FORCE_U32 = 0x7FFFFFFF

## 
##     sg_vertex_format
## 
##     The data type of a vertex component. This is used to describe
##     the layout of vertex data when creating a pipeline object.
## 

type
  sg_vertex_format* = enum
    SG_VERTEXFORMAT_INVALID, SG_VERTEXFORMAT_FLOAT, SG_VERTEXFORMAT_FLOAT2,
    SG_VERTEXFORMAT_FLOAT3, SG_VERTEXFORMAT_FLOAT4, SG_VERTEXFORMAT_BYTE4,
    SG_VERTEXFORMAT_BYTE4N, SG_VERTEXFORMAT_UBYTE4, SG_VERTEXFORMAT_UBYTE4N,
    SG_VERTEXFORMAT_SHORT2, SG_VERTEXFORMAT_SHORT2N, SG_VERTEXFORMAT_SHORT4,
    SG_VERTEXFORMAT_SHORT4N, SG_VERTEXFORMAT_UINT10_N2, 
    SG_VERTEXFORMAT_NUM,
    SG_VERTEXFORMAT_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_vertex_step
## 
##     Defines whether the input pointer of a vertex input stream is advanced
##     'per vertex' or 'per instance'. The default step-func is
##     SG_VERTEXSTEP_PER_VERTEX. SG_VERTEXSTEP_PER_INSTANCE is used with
##     instanced-rendering.
## 
##     The vertex-step is part of the vertex-layout definition
##     when creating pipeline objects.
## 

type
  sg_vertex_step* = enum
    SG_VERTEXSTEP_DEFAULT,   ##  value 0 reserved for default-init
    SG_VERTEXSTEP_PER_VERTEX, SG_VERTEXSTEP_PER_INSTANCE,
    SG_VERTEXSTEP_NUM,
    SG_VERTEXSTEP_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_uniform_type
## 
##     The data type of a uniform block member. This is used to 
##     describe the internal layout of uniform blocks when creating
##     a shader object.
## 

type
  sg_uniform_type* = enum
    SG_UNIFORMTYPE_INVALID, SG_UNIFORMTYPE_FLOAT, SG_UNIFORMTYPE_FLOAT2,
    SG_UNIFORMTYPE_FLOAT3, SG_UNIFORMTYPE_FLOAT4, SG_UNIFORMTYPE_MAT4,
    SG_UNIFORMTYPE_NUM,
    SG_UNIFORMTYPE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_cull_mode
## 
##     The face-culling mode, this is used in the
##     sg_pipeline_desc.rasterizer.cull_mode member when creating a 
##     pipeline object.
## 
##     The default cull mode is SG_CULLMODE_NONE
## 

type
  sg_cull_mode* = enum
    SG_CULLMODE_DEFAULT,     ##  value 0 reserved for default-init
    SG_CULLMODE_NONE, SG_CULLMODE_FRONT, SG_CULLMODE_BACK, 
    SG_CULLMODE_NUM,
    SG_CULLMODE_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_face_winding
## 
##     The vertex-winding rule that determines a front-facing primitive. This
##     is used in the member sg_pipeline_desc.rasterizer.face_winding
##     when creating a pipeline object.
## 
##     The default winding is SG_FACEWINDING_CW (clockwise)
## 

type
  sg_face_winding* = enum
    SG_FACEWINDING_DEFAULT,  ##  value 0 reserved for default-init
    SG_FACEWINDING_CCW, SG_FACEWINDING_CW, 
    SG_FACEWINDING_NUM,
    SG_FACEWINDING_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_compare_func
## 
##     The compare-function for depth- and stencil-ref tests.
##     This is used when creating pipeline objects in the members:
##    
##     sg_pipeline_desc
##         .depth_stencil
##             .depth_compare_func
##             .stencil_front.compare_func
##             .stencil_back.compare_func
## 
##     The default compare func for depth- and stencil-tests is
##     SG_COMPAREFUNC_ALWAYS.
## 

type
  sg_compare_func* = enum
    SG_COMPAREFUNC_DEFAULT,  ##  value 0 reserved for default-init
    SG_COMPAREFUNC_NEVER, SG_COMPAREFUNC_LESS, SG_COMPAREFUNC_EQUAL,
    SG_COMPAREFUNC_LESS_EQUAL, SG_COMPAREFUNC_GREATER, SG_COMPAREFUNC_NOT_EQUAL,
    SG_COMPAREFUNC_GREATER_EQUAL, SG_COMPAREFUNC_ALWAYS, 
    SG_COMPAREFUNC_NUM,
    SG_COMPAREFUNC_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_stencil_op
## 
##     The operation performed on a currently stored stencil-value when a
##     comparison test passes or fails. This is used when creating a pipeline
##     object in the members:
## 
##     sg_pipeline_desc
##         .depth_stencil
##             .stencil_front
##                 .fail_op
##                 .depth_fail_op
##                 .pass_op
##             .stencil_back
##                 .fail_op
##                 .depth_fail_op
##                 .pass_op
## 
##     The default value is SG_STENCILOP_KEEP.
## 

type
  sg_stencil_op* = enum
    SG_STENCILOP_DEFAULT,    ##  value 0 reserved for default-init
    SG_STENCILOP_KEEP, SG_STENCILOP_ZERO, SG_STENCILOP_REPLACE,
    SG_STENCILOP_INCR_CLAMP, SG_STENCILOP_DECR_CLAMP, SG_STENCILOP_INVERT,
    SG_STENCILOP_INCR_WRAP, SG_STENCILOP_DECR_WRAP, 
    SG_STENCILOP_NUM,
    SG_STENCILOP_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_blend_factor
## 
##     The source and destination factors in blending operations.
##     This is used in the following members when creating a pipeline object:
## 
##     sg_pipeline_desc
##         .blend
##             .src_factor_rgb
##             .dst_factor_rgb
##             .src_factor_alpha
##             .dst_factor_alpha
## 
##     The default value is SG_BLENDFACTOR_ONE for source
##     factors, and SG_BLENDFACTOR_ZERO for destination factors.
## 

type
  sg_blend_factor* = enum
    SG_BLENDFACTOR_DEFAULT,  ##  value 0 reserved for default-init
    SG_BLENDFACTOR_ZERO, SG_BLENDFACTOR_ONE, SG_BLENDFACTOR_SRC_COLOR,
    SG_BLENDFACTOR_ONE_MINUS_SRC_COLOR, SG_BLENDFACTOR_SRC_ALPHA,
    SG_BLENDFACTOR_ONE_MINUS_SRC_ALPHA, SG_BLENDFACTOR_DST_COLOR,
    SG_BLENDFACTOR_ONE_MINUS_DST_COLOR, SG_BLENDFACTOR_DST_ALPHA,
    SG_BLENDFACTOR_ONE_MINUS_DST_ALPHA, SG_BLENDFACTOR_SRC_ALPHA_SATURATED,
    SG_BLENDFACTOR_BLEND_COLOR, SG_BLENDFACTOR_ONE_MINUS_BLEND_COLOR,
    SG_BLENDFACTOR_BLEND_ALPHA, SG_BLENDFACTOR_ONE_MINUS_BLEND_ALPHA,
    SG_BLENDFACTOR_NUM,
    SG_BLENDFACTOR_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_blend_op
## 
##     Describes how the source and destination values are combined in the
##     fragment blending operation. It is used in the following members when
##     creating a pipeline object:
## 
##     sg_pipeline_desc
##         .blend
##             .op_rgb
##             .op_alpha
## 
##     The default value is SG_BLENDOP_ADD.
## 

type
  sg_blend_op* = enum
    SG_BLENDOP_DEFAULT,      ##  value 0 reserved for default-init
    SG_BLENDOP_ADD, SG_BLENDOP_SUBTRACT, SG_BLENDOP_REVERSE_SUBTRACT,
    SG_BLENDOP_NUM,
    SG_BLENDOP_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_color_mask
## 
##     Selects the color channels when writing a fragment color to the
##     framebuffer. This is used in the members
##     sg_pipeline_desc.blend.color_write_mask when creating a pipeline object.
## 
##     The default colormask is SG_COLORMASK_RGBA (write all colors channels)
## 

type
  sg_color_mask* = enum
    SG_COLORMASK_DEFAULT = 0,  ##  value 0 reserved for default-init
    SG_COLORMASK_R = 1, SG_COLORMASK_G = 2, SG_COLORMASK_B = 4,
    SG_COLPRMASK_RGB = 0x7,
    SG_COLORMASK_A = 8, 
    SG_COLORMASK_RGBA = 0xF,
    SG_COLORMASK_NONE = 0x10 ##  special value for 'all channels disabled
    SG_COLORMASK_FORCE_U32 = 0x7FFFFFFF


## 
##     sg_action
## 
##     Defines what action should be performed at the start of a render pass:
## 
##     SG_ACTION_CLEAR:    clear the render target image
##     SG_ACTION_LOAD:     load the previous content of the render target image
##     SG_ACTION_DONTCARE: leave the render target image content undefined
## 
##     This is used in the sg_pass_action structure. 
##     
##     The default action for all pass attachments is SG_ACTION_CLEAR, with the
##     clear color rgba = {0.5f, 0.5f, 0.5f, 1.0f], depth=1.0 and stencil=0.
## 
##     If you want to override the default behaviour, it is important to not
##     only set the clear color, but the 'action' field as well (as long as this
##     is in its SG_ACTION_DEFAULT, the value fields will be ignored).
## 

type
  sg_action* = enum
    SG_ACTION_DEFAULT, SG_ACTION_CLEAR, SG_ACTION_LOAD, SG_ACTION_DONTCARE,
    SG_ACTION_NUM,
    SG_ACTION_FORCE_U32=0x7FFFFFFF


## 
##     sg_pass_action
## 
##     The sg_pass_action struct defines the actions to be performed
##     at the start of a rendering pass in the functions sg_begin_pass()
##     and sg_begin_default_pass().
## 
##     A separate action and clear values can be defined for each
##     color attachment, and for the depth-stencil attachment.
## 
##     The default clear values are defined by the macros:
## 
##     - SG_DEFAULT_CLEAR_RED:     0.5f
##     - SG_DEFAULT_CLEAR_GREEN:   0.5f
##     - SG_DEFAULT_CLEAR_BLUE:    0.5f
##     - SG_DEFAULT_CLEAR_ALPHA:   1.0f
##     - SG_DEFAULT_CLEAR_DEPTH:   1.0f
##     - SG_DEFAULT_CLEAR_STENCIL: 0
## 

type
  sg_color_attachment_action* {.bycopy.} = object
    action*: sg_action
    val*: array[4, cfloat]

  sg_depth_attachment_action* {.bycopy.} = object
    action*: sg_action
    val*: cfloat

  sg_stencil_attachment_action* {.bycopy.} = object
    action*: sg_action
    val*: uint8

  sg_pass_action* {.bycopy.} = object
    start_canary: uint32
    colors*: array[SG_MAX_COLOR_ATTACHMENTS, sg_color_attachment_action]
    depth*: sg_depth_attachment_action
    stencil*: sg_stencil_attachment_action
    end_canary: uint32


## 
##     sg_draw_state
## 
##     The sg_draw_state structure defines the resource binding slots
##     of the sokol_gfx render pipeline, used as argument to the
##     sg_apply_draw_state() function.
## 
##     A draw state contains:
## 
##     - 1 pipeline object
##     - 1..N vertex buffers
##     - 0..1 index buffers
##     - 0..N vertex shader stage images
##     - 0..N fragment shader stage images
## 
##     The max number of vertex buffer and shader stage images
##     are defined by the SG_MAX_SHADERSTAGE_BUFFERS and
##     SG_MAX_SHADERSTAGE_IMAGES configuration constants.
## 

type
  sg_draw_state* {.bycopy.} = object
    start_canary: uint32
    pipeline*: sg_pipeline
    vertex_buffers*: array[SG_MAX_SHADERSTAGE_BUFFERS, sg_buffer]
    index_buffer*: sg_buffer
    vs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    fs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    end_canary: uint32


## 
##     sg_desc
## 
##     The sg_desc struct contains configuration values for sokol_gfx,
##     it is used as parameter to the sg_setup() call.
## 
##     The default configuration is:
## 
##     .buffer_pool_size:      128
##     .image_pool_size:       128
##     .shader_pool_size:      32
##     .pipeline_pool_size:    64
##     .pass_pool_size:        16 
##     
##     GL specific:
##     .gl_force_gles2
##         if this is true the GL backend will act in "GLES2 fallback mode" even
##         when compiled with SOKOL_GLES3, this is useful to fall back 
##         to traditional WebGL if a browser doesn't support a WebGL2 context
## 
##     Metal specific:
##         (NOTE: All Objective-C object references are transferred through
##         a bridged (const void*) to sokol_gfx, which will use a unretained
##         bridged cast (__bridged id<xxx>) to retrieve the Objective-C
##         references back. Since the bridge cast is unretained, the caller
##         must hold a strong reference to the Objective-C object for the 
##         duration of the sokol_gfx call!
## 
##     .mtl_device     
##         a pointer to the MTLDevice object
##     .mtl_renderpass_descriptor_cb
##         a C callback function to obtain the MTLRenderPassDescriptor for the 
##         current frame when rendering to the default framebuffer, will be called
##         in sg_begin_default_pass()
##     .mtl_drawable_cb
##         a C callback function to obtain a MTLDrawable for the current
##         frame when rendering to the default framebuffer, will be called in
##         sg_end_pass() of the default pass
##     .mtl_global_uniform_buffer_size
##         the size of the global uniform buffer in bytes, this must be big
##         enough to hold all uniform block updates for a single frame,
##         the default value is 4 MByte (4 * 1024 * 1024)
##     .mtl_sampler_cache_size
##         the number of slots in the sampler cache, the Metal backend
##         will share texture samplers with the same state in this 
##         cache, the default value is 64
## 
##     D3D11 specific:
##     .d3d11_device
##         a pointer to the ID3D11Device object, this must have been created 
##         before sg_setup() is called
##     .d3d11_device_context
##         a pointer to the ID3D11DeviceContext object
##     .d3d11_render_target_view_cb
##         a C callback function to obtain a pointer to the current
##         ID3D11RenderTargetView object of the default framebuffer,
##         this function will be called in sg_begin_pass() when rendering
##         to the default framebuffer
##     .d3d11_depth_stencil_view_cb
##         a C callback function to obtain a pointer to the current
##         ID3D11DepthStencilView object of the default framebuffer,
##         this function will be called in sg_begin_pass() when rendering
##         to the default framebuffer
## 

type
  sg_desc* {.bycopy.} = object
    start_canary: uint32
    buffer_pool_size*: cint
    image_pool_size*: cint
    shader_pool_size*: cint
    pipeline_pool_size*: cint
    pass_pool_size*: cint      ##  GL specific
    gl_force_gles2*: bool      ##  Metal-specific
    mtl_device*: pointer
    mtl_renderpass_descriptor_cb*: proc (): pointer
    mtl_drawable_cb*: proc (): pointer
    mtl_global_uniform_buffer_size*: cint
    mtl_sampler_cache_size*: cint ##  D3D11-specific
    d3d11_device*: pointer
    d3d11_device_context*: pointer
    d3d11_render_target_view_cb*: proc (): pointer
    d3d11_depth_stencil_view_cb*: proc (): pointer
    end_canary: uint32


## 
##     sg_buffer_desc
## 
##     Creation parameters for sg_buffer objects, used in the
##     sg_make_buffer() call.
## 
##     The default configuration is:
## 
##     .size:      0       (this *must* be set to a valid size in bytes)
##     .type:      SG_BUFFERTYPE_VERTEXBUFFER
##     .usage:     SG_USAGE_IMMUTABLE
##     .content    0
## 
##     Buffers with the SG_USAGE_IMMUTABLE usage *must* fill the buffer
##     with initial data (.content must point to a data chunk with
##     exactly .size bytes).
## 
##     ADVANCED TOPIC: Injecting native 3D-API buffers:
## 
##     The following struct members allow to inject your own GL, Metal
##     or D3D11 buffers into sokol_gfx:
##     
##     .gl_buffers[SG_NUM_INFLIGHT_FRAMES]
##     .mtl_buffers[SG_NUM_INFLIGHT_FRAMES]
##     .d3d11_buffer
## 
##     You must still provide all other members except the .content member, and
##     these must match the creation parameters of the native buffers you
##     provide. For SG_USAGE_IMMUTABLE, only provide a single native 3D-API
##     buffer, otherwise you need to provide SG_NUM_INFLIGHT_FRAMES buffers
##     (only for GL and Metal, not D3D11). Providing multiple buffers for GL and
##     Metal is necessary because sokol_gfx will rotate through them when
##     calling sg_update_buffer() to prevent lock-stalls.
## 
##     Note that it is expected that immutable injected buffer have already been
##     initialized with content, and the .content member must be 0!
## 
##     Also you need to call sg_reset_state_cache() after calling native 3D-API
##     functions, and before calling any sokol_gfx function.
## 

type
  sg_buffer_desc* {.bycopy.} = object
    start_canary: uint32
    size*: cint
    `type`*: sg_buffer_type
    usage*: sg_usage
    content*: pointer          ##  GL specific
    gl_buffers*: array[SG_NUM_INFLIGHT_FRAMES, uint32] ##  Metal specific
    mtl_buffers*: array[SG_NUM_INFLIGHT_FRAMES, pointer] ##  D3D11 specific
    d3d11_buffer*: pointer
    end_canary: uint32


## 
##     sg_subimage_content
## 
##     Pointer to and size of a subimage-surface data, this is
##     used to describe the initial content of immutable-usage images,
##     or for updating a dynamic- or stream-usage images.
## 
##     For 3D- or array-textures, one sg_subimage_content item
##     describes an entire mipmap level consisting of all array- or
##     3D-slices of the mipmap level. It is only possible to update
##     an entire mipmap level, not parts of it.
## 

type
  sg_subimage_content* {.bycopy.} = object
    `ptr`*: pointer            ##  pointer to subimage data
    size*: cint                ##  size in bytes of pointed-to subimage data
  

## 
##     sg_image_content
## 
##     Defines the content of an image through a 2D array
##     of sg_subimage_content structs. The first array dimension
##     is the cubemap face, and the second array dimension the
##     mipmap level.
## 

type
  sg_image_content* {.bycopy.} = object
    subimage*: array[SG_CUBEFACE_NUM, array[SG_MAX_MIPMAPS, sg_subimage_content]]


## 
##     sg_image_desc
## 
##     Creation parameters for sg_image objects, used in the 
##     sg_make_image() call.
## 
##     The default configuration is:
## 
##     .type:              SG_IMAGETYPE_2D
##     .render_target:     false
##     .width              0 (must be set to >0)
##     .height             0 (must be set to >0)
##     .depth/.layers:     1
##     .num_mipmaps:       1
##     .usage:             SG_USAGE_IMMUTABLE
##     .pixel_format:      SG_PIXELFORMAT_RGBA8
##     .sample_count:      1 (only used in render_targets)
##     .min_filter:        SG_FILTER_NEAREST
##     .mag_filter:        SG_FILTER_NEAREST
##     .wrap_u:            SG_WRAP_REPEAT
##     .wrap_v:            SG_WRAP_REPEAT
##     .wrap_w:            SG_WRAP_REPEAT (only SG_IMAGETYPE_3D)
##     .max_anisotropy     1 (must be 1..16)
##     .min_lod            0.0f
##     .max_lod            FLT_MAX
##     .content            an sg_image_content struct to define the initial content 
## 
##     SG_IMAGETYPE_ARRAY and SG_IMAGETYPE_3D are not supported on
##     WebGL/GLES2, use sg_query_feature(SG_FEATURE_IMAGETYPE_ARRAY) and
##     sg_query_feature(SG_FEATURE_IMAGETYPE_3D) at runtime to check
##     if array- and 3D-textures are supported.
## 
##     Images with usage SG_USAGE_IMMUTABLE must be fully initialized by
##     providing a valid .content member which points to
##     initialization data.
##     
##     ADVANCED TOPIC: Injecting native 3D-API textures:
## 
##     The following struct members allow to inject your own GL, Metal
##     or D3D11 textures into sokol_gfx:
##     
##     .gl_textures[SG_NUM_INFLIGHT_FRAMES]
##     .mtl_textures[SG_NUM_INFLIGHT_FRAMES]
##     .d3d11_texture
## 
##     The same rules apply as for injecting native buffers
##     (see sg_buffer_desc documentation for more details).
## 

type
  INNER_C_UNION_3509626565* {.bycopy.} = object {.union.}
    depth*: cint
    layers*: cint

  sg_image_desc* {.bycopy.} = object
    start_canary: uint32
    `type`*: sg_image_type
    render_target*: bool
    width*: cint
    height*: cint
    ano_4199846771*: INNER_C_UNION_3509626565
    num_mipmaps*: cint
    usage*: sg_usage
    pixel_format*: sg_pixel_format
    sample_count*: cint
    min_filter*: sg_filter
    mag_filter*: sg_filter
    wrap_u*: sg_wrap
    wrap_v*: sg_wrap
    wrap_w*: sg_wrap
    max_anisotropy*: uint32
    min_lod*: cfloat
    max_lod*: cfloat
    content*: sg_image_content ##  GL specific
    gl_textures*: array[SG_NUM_INFLIGHT_FRAMES, uint32] ##  Metal specific
    mtl_textures*: array[SG_NUM_INFLIGHT_FRAMES, pointer] ##  D3D11 specific
    d3d11_texture*: pointer
    end_canary: uint32


## 
##     sg_shader_desc
## 
##     The structure sg_shader_desc describes the shaders, uniform blocks
##     and texture images on the vertex- and fragment-shader stage.
## 
##     TODO: source code vs byte code, 3D backend API specifics.
## 

type
  sg_shader_uniform_desc* {.bycopy.} = object
    name*: cstring
    `type`*: sg_uniform_type
    array_count*: cint

  sg_shader_uniform_block_desc* {.bycopy.} = object
    size*: cint
    uniforms*: array[SG_MAX_UB_MEMBERS, sg_shader_uniform_desc]

  sg_shader_image_desc* {.bycopy.} = object
    name*: cstring
    `type`*: sg_image_type

  sg_shader_stage_desc* {.bycopy.} = object
    source*: cstring
    byte_code*: ptr uint8
    byte_code_size*: cint
    entry*: cstring
    uniform_blocks*: array[SG_MAX_SHADERSTAGE_UBS, sg_shader_uniform_block_desc]
    images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_shader_image_desc]

  sg_shader_desc* {.bycopy.} = object
    start_canary: uint32
    vs*: sg_shader_stage_desc
    fs*: sg_shader_stage_desc
    end_canary: uint32


## 
##     sg_pipeline_desc
## 
##     The sg_pipeline_desc struct defines all creation parameters
##     for an sg_pipeline object, used as argument to the
##     sg_make_pipeline() function:
## 
##     - the complete vertex layout for all input vertex buffers
##     - a shader object
##     - the 3D primitive type (points, lines, triangles, ...)
##     - the index type (none, 16- or 32-bit)
##     - depth-stencil state
##     - alpha-blending state
##     - rasterizer state
## 
##     If the vertex data has no gaps between vertex components, you can omit
##     the .layout.buffers[].stride and layout.attrs[].offset items (leave them 
##     default-initialized to 0), sokol will then compute the offsets and strides
##     from the vertex component formats (.layout.attrs[].offset). Please note
##     that ALL vertex attribute offsets must be 0 in order for the the
##     automatic offset computation to kick in.
## 
##     The default configuration is as follows:
## 
##     .layout:
##         .buffers[]:         vertex buffer layouts
##             .stride:        0 (if no stride is given it will be computed)
##             .step_func      SG_VERTEXSTEP_PER_VERTEX
##             .step_rate      1
##         .attrs[]:           vertex attribute declarations
##             .buffer_index   0 the vertex buffer bind slot  
##             .offset         0 (offsets can be omitted if the vertex layout has no gaps)
##             .format         SG_VERTEXFORMAT_INVALID (must be initialized!)
##             .name           0 (GLES2 requires an attribute name here)
##             .sem_name       0 (D3D11 requires a semantic name here)
##             .sem_index      0 (D3D11 requires a semantic index here)
##     .shader:            0 (must be intilized with a valid sg_shader id!)
##     .primitive_type:    SG_PRIMITIVETYPE_TRIANGLES
##     .index_type:        SG_INDEXTYPE_NONE
##     .depth_stencil:
##         .stencil_front, .stencil_back:
##             .fail_op:               SG_STENCILOP_KEEP
##             .depth_fail_op:         SG_STENCILOP_KEEP
##             .pass_op:               SG_STENCILOP_KEEP
##             .compare_func           SG_COMPAREFUNC_ALWAYS
##         .depth_compare_func:    SG_COMPAREFUNC_ALWAYS
##         .depth_write_enabled:   false
##         .stencil_enabled:       false
##         .stencil_read_mask:     0
##         .stencil_write_mask:    0
##         .stencil_ref:           0
##     .blend:
##         .enabled:               false
##         .src_factor_rgb:        SG_BLENDFACTOR_ONE
##         .dst_factor_rgb:        SG_BLENDFACTOR_ZERO
##         .op_rgb:                SG_BLENDOP_ADD
##         .src_factor_alpha:      SG_BLENDFACTOR_ONE
##         .dst_factor_alpha:      SG_BLENDFACTOR_ZERO
##         .op_alpha:              SG_BLENDOP_ADD
##         .color_write_mask:      SG_COLORMASK_RGBA
##         .color_attachment_count 1
##         .color_format           SG_PIXELFORMAT_RGBA8
##         .depth_format           SG_PIXELFORMAT_DEPTHSTENCIL
##         .blend_color:           { 0.0f, 0.0f, 0.0f, 0.0f }
##     .rasterizer:
##         .alpha_to_coverage_enabled:     false
##         .cull_mode:                     SG_CULLMODE_NONE
##         .face_winding:                  SG_FACEWINDING_CW
##         .sample_count:                  1
##         .depth_bias:                    0.0f
##         .depth_bias_slope_scale:        0.0f
##         .depth_bias_clamp:              0.0f
## 

type
  sg_buffer_layout_desc* {.bycopy.} = object
    stride*: cint
    step_func*: sg_vertex_step
    step_rate*: cint

  sg_vertex_attr_desc* {.bycopy.} = object
    name*: cstring
    sem_name*: cstring
    sem_index*: cint
    buffer_index*: cint
    offset*: cint
    format*: sg_vertex_format

  sg_layout_desc* {.bycopy.} = object
    buffers*: array[SG_MAX_SHADERSTAGE_BUFFERS, sg_buffer_layout_desc]
    attrs*: array[SG_MAX_VERTEX_ATTRIBUTES, sg_vertex_attr_desc]

  sg_stencil_state* {.bycopy.} = object
    fail_op*: sg_stencil_op
    depth_fail_op*: sg_stencil_op
    pass_op*: sg_stencil_op
    compare_func*: sg_compare_func

  sg_depth_stencil_state* {.bycopy.} = object
    stencil_front*: sg_stencil_state
    stencil_back*: sg_stencil_state
    depth_compare_func*: sg_compare_func
    depth_write_enabled*: bool
    stencil_enabled*: bool
    stencil_read_mask*: uint8
    stencil_write_mask*: uint8
    stencil_ref*: uint8

  sg_blend_state* {.bycopy.} = object
    enabled*: bool
    src_factor_rgb*: sg_blend_factor
    dst_factor_rgb*: sg_blend_factor
    op_rgb*: sg_blend_op
    src_factor_alpha*: sg_blend_factor
    dst_factor_alpha*: sg_blend_factor
    op_alpha*: sg_blend_op
    color_write_mask*: uint8
    color_attachment_count*: cint
    color_format*: sg_pixel_format
    depth_format*: sg_pixel_format
    blend_color*: array[4, cfloat]

  sg_rasterizer_state* {.bycopy.} = object
    alpha_to_coverage_enabled*: bool
    cull_mode*: sg_cull_mode
    face_winding*: sg_face_winding
    sample_count*: cint
    depth_bias*: cfloat
    depth_bias_slope_scale*: cfloat
    depth_bias_clamp*: cfloat

  sg_pipeline_desc* {.bycopy.} = object
    start_canary: uint32
    layout*: sg_layout_desc
    shader*: sg_shader
    primitive_type*: sg_primitive_type
    index_type*: sg_index_type
    depth_stencil*: sg_depth_stencil_state
    blend*: sg_blend_state
    rasterizer*: sg_rasterizer_state
    end_canary: uint32


## 
##     sg_pass_desc
## 
##     Creation parameters for an sg_pass object, used as argument
##     to the sg_make_pass() function.
## 
##     A pass object contains 1..4 color-attachments and none, or one,
##     depth-stencil-attachment. Each attachment consists of
##     an image, and two additional indices describing
##     which subimage the pass will render: one mipmap index, and
##     if the image is a cubemap, array-texture or 3D-texture, the
##     face-index, array-layer or depth-slice.
## 
##     Pass images must fulfill the following requirements:
## 
##     All images must have:
##     - been created as render target (sg_image_desc.render_target = true)
##     - the same size
##     - the same sample count
##     
##     In addition, all color-attachment images must have the same
##     pixel format.
## 

type
  INNER_C_UNION_221963591* {.bycopy.} = object {.union.}
    face*: cint
    layer*: cint
    slice*: cint

  sg_attachment_desc* {.bycopy.} = object
    image*: sg_image
    mip_level*: cint
    ano_1019651058*: INNER_C_UNION_221963591

  sg_pass_desc* {.bycopy.} = object
    start_canary: uint32
    color_attachments*: array[SG_MAX_COLOR_ATTACHMENTS, sg_attachment_desc]
    depth_stencil_attachment*: sg_attachment_desc
    end_canary: uint32

proc sg_setup(desc: ptr sg_desc) {.importc:"sg_setup",cdecl.}
proc setup*(desc: var sg_desc) = sg_setup(addr(desc))
proc shutdown*() {.importc:"sg_shutdown",cdecl.}
proc isvalid*(): bool {.importc:"sg_isvalid",cdecl.}
#proc sg_query_feature*(feature: sg_feature): bool
#proc sg_reset_state_cache*()
#proc sg_make_buffer*(desc: ptr sg_buffer_desc): sg_buffer
#proc sg_make_image*(desc: ptr sg_image_desc): sg_image
#proc sg_make_shader*(desc: ptr sg_shader_desc): sg_shader
#proc sg_make_pipeline*(desc: ptr sg_pipeline_desc): sg_pipeline
#proc sg_make_pass*(desc: ptr sg_pass_desc): sg_pass
#proc sg_destroy_buffer*(buf: sg_buffer)
#proc sg_destroy_image*(img: sg_image)
#proc sg_destroy_shader*(shd: sg_shader)
#proc sg_destroy_pipeline*(pip: sg_pipeline)
#proc sg_destroy_pass*(pass: sg_pass)
#proc sg_update_buffer*(buf: sg_buffer; data_ptr: pointer; data_size: cint)
#proc sg_update_image*(img: sg_image; data: ptr sg_image_content)
#proc sg_query_buffer_state*(buf: sg_buffer): sg_resource_state
#proc sg_query_image_state*(img: sg_image): sg_resource_state
#proc sg_query_shader_state*(shd: sg_shader): sg_resource_state
#proc sg_query_pipeline_state*(pip: sg_pipeline): sg_resource_state
#proc sg_query_pass_state*(pass: sg_pass): sg_resource_state
proc sg_begin_default_pass(pass_action: ptr sg_pass_action, width: cint, height: cint) {.importc:"sg_begin_default_pass",cdecl.}
proc begin_default_pass*(pass_action: var sg_pass_action, width: cint, height: cint) = sg_begin_default_pass(addr(pass_action), width, height)
#proc sg_begin_pass*(pass: sg_pass; pass_action: ptr sg_pass_action)
# proc sg_apply_viewport*(x: cint; y: cint; width: cint; height: cint; origin_top_left: bool)
#proc sg_apply_scissor_rect*(x: cint; y: cint; width: cint; height: cint; origin_top_left: bool)
# proc sg_apply_draw_state*(ds: ptr sg_draw_state)
#proc sg_apply_uniform_block*(stage: sg_shader_stage; ub_index: cint; data: pointer; num_bytes: cint)
#proc sg_draw*(base_element: cint; num_elements: cint; num_instances: cint)
proc end_pass*() {.importc:"sg_end_pass",cdecl.}
proc commit*() {.importc:"sg_commit",cdecl.}
#proc sg_alloc_buffer*(): sg_buffer
#proc sg_alloc_image*(): sg_image
#proc sg_alloc_shader*(): sg_shader
# proc sg_alloc_pipeline*(): sg_pipeline
# proc sg_alloc_pass*(): sg_pass
#proc sg_init_buffer*(buf_id: sg_buffer; desc: ptr sg_buffer_desc)
#proc sg_init_image*(img_id: sg_image; desc: ptr sg_image_desc)
# proc sg_init_shader*(shd_id: sg_shader; desc: ptr sg_shader_desc)
#proc sg_init_pipeline*(pip_id: sg_pipeline; desc: ptr sg_pipeline_desc)
#proc sg_init_pass*(pass_id: sg_pass; desc: ptr sg_pass_desc)
#proc sg_fail_buffer*(buf_id: sg_buffer)
#proc sg_fail_image*(img_id: sg_image)
#proc sg_fail_shader*(shd_id: sg_shader)
#proc sg_fail_pipeline*(pip_id: sg_pipeline)
#proc sg_fail_pass*(pass_id: sg_pass)
