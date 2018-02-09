{.deadCodeElim: on.}
{.compile: "native/sokol.c".}
{.passL: "-framework OpenGL -framework Foundation".}
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

type
  sg_feature* = enum
    SG_FEATURE_INSTANCING, SG_FEATURE_TEXTURE_COMPRESSION_DXT,
    SG_FEATURE_TEXTURE_COMPRESSION_PVRTC, SG_FEATURE_TEXTURE_COMPRESSION_ATC,
    SG_FEATURE_TEXTURE_COMPRESSION_ETC2, SG_FEATURE_TEXTURE_FLOAT,
    SG_FEATURE_TEXTURE_HALF_FLOAT, SG_FEATURE_ORIGIN_BOTTOM_LEFT,
    SG_FEATURE_ORIGIN_TOP_LEFT, SG_FEATURE_MSAA_RENDER_TARGETS,
    SG_FEATURE_PACKED_VERTEX_FORMAT_10_2, SG_FEATURE_MULTIPLE_RENDER_TARGET,
    SG_FEATURE_IMAGETYPE_3D, SG_FEATURE_IMAGETYPE_ARRAY, SG_NUM_FEATURES


type
  sg_resource_state* = enum
    SG_RESOURCESTATE_INITIAL, SG_RESOURCESTATE_ALLOC, SG_RESOURCESTATE_VALID,
    SG_RESOURCESTATE_FAILED, SG_RESOURCESTATE_INVALID,
    SG_RESOURCESTATE_FORCE_U32 = 0x7FFFFFFF


type
  sg_usage* = enum
    SG_USAGE_DEFAULT,        ##  value 0 reserved for default-init
    SG_USAGE_IMMUTABLE, SG_USAGE_DYNAMIC, SG_USAGE_STREAM,
    SG_USAGE_NUM,
    SG_USAGE_FORCE_U32 = 0x7FFFFFFF

type
  sg_buffer_type* = enum
    SG_BUFFERTYPE_DEFAULT,   ##  value 0 reserved for default-init
    SG_BUFFERTYPE_VERTEXBUFFER, SG_BUFFERTYPE_INDEXBUFFER,
    SG_BUFFERTYPE_NUM,
    SG_BUFFERTYPE_FORCE_U32 = 0x7FFFFFFF

type
  sg_index_type* = enum
    SG_INDEXTYPE_DEFAULT,    ##  value 0 reserved for default-init
    SG_INDEXTYPE_NONE, SG_INDEXTYPE_UINT16, SG_INDEXTYPE_UINT32,
    SG_INDEXTYPE_NUM,
    SG_INDEXTYPE_FORCE_U32 = 0x7FFFFFFF

type
  sg_image_type* = enum
    SG_IMAGETYPE_DEFAULT,    ##  value 0 reserved for default-init
    SG_IMAGETYPE_2D, SG_IMAGETYPE_CUBE, SG_IMAGETYPE_3D, SG_IMAGETYPE_ARRAY,
    SG_IMAGETYPE_NUM,
    SG_IMAGETYPE_FORCE_U32 = 0x7FFFFFFF

type
  sg_cube_face* = enum
    SG_CUBEFACE_POS_X,
    SG_CUBEFACE_NEG_X, 
    SG_CUBEFACE_POS_Y, 
    SG_CUBEFACE_NEG_Y,
    SG_CUBEFACE_POS_Z,
    SG_CUBEFACE_NEG_Z,
    SG_CUBEFACE_NUM

type
  sg_shader_stage* = enum
    SG_SHADERSTAGE_VS, SG_SHADERSTAGE_FS
    SG_SHADERSTAGE_FORCE_U32 = 0x7FFFFFFF

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

type
  sg_primitive_type* = enum
    SG_PRIMITIVETYPE_DEFAULT, ##  value 0 reserved for default-init
    SG_PRIMITIVETYPE_POINTS, SG_PRIMITIVETYPE_LINES, SG_PRIMITIVETYPE_LINE_STRIP,
    SG_PRIMITIVETYPE_TRIANGLES, SG_PRIMITIVETYPE_TRIANGLE_STRIP,
    SG_PRIMITIVETYPE_NUM,
    SG_PRIMITIVETYPE_FORCE_U32 = 0x7FFFFFFF

type
  sg_filter* = enum
    SG_FILTER_DEFAULT,       ##  value 0 reserved for default-init
    SG_FILTER_NEAREST, SG_FILTER_LINEAR, SG_FILTER_NEAREST_MIPMAP_NEAREST,
    SG_FILTER_NEAREST_MIPMAP_LINEAR, SG_FILTER_LINEAR_MIPMAP_NEAREST,
    SG_FILTER_LINEAR_MIPMAP_LINEAR, 
    SG_FILTER_NUM,
    SG_FILTER_FORCE_U32 = 0x7FFFFFFF

type
  sg_wrap* = enum
    SG_WRAP_DEFAULT,         ##  value 0 reserved for default-init
    SG_WRAP_REPEAT, SG_WRAP_CLAMP_TO_EDGE, SG_WRAP_MIRRORED_REPEAT, 
    SG_WRAP_NUM,
    SG_WRAP_FORCE_U32 = 0x7FFFFFFF

type
  sg_vertex_format* = enum
    SG_VERTEXFORMAT_INVALID, SG_VERTEXFORMAT_FLOAT, SG_VERTEXFORMAT_FLOAT2,
    SG_VERTEXFORMAT_FLOAT3, SG_VERTEXFORMAT_FLOAT4, SG_VERTEXFORMAT_BYTE4,
    SG_VERTEXFORMAT_BYTE4N, SG_VERTEXFORMAT_UBYTE4, SG_VERTEXFORMAT_UBYTE4N,
    SG_VERTEXFORMAT_SHORT2, SG_VERTEXFORMAT_SHORT2N, SG_VERTEXFORMAT_SHORT4,
    SG_VERTEXFORMAT_SHORT4N, SG_VERTEXFORMAT_UINT10_N2, 
    SG_VERTEXFORMAT_NUM,
    SG_VERTEXFORMAT_FORCE_U32 = 0x7FFFFFFF

type
  sg_vertex_step* = enum
    SG_VERTEXSTEP_DEFAULT,   ##  value 0 reserved for default-init
    SG_VERTEXSTEP_PER_VERTEX, SG_VERTEXSTEP_PER_INSTANCE,
    SG_VERTEXSTEP_NUM,
    SG_VERTEXSTEP_FORCE_U32 = 0x7FFFFFFF

type
  sg_uniform_type* = enum
    SG_UNIFORMTYPE_INVALID, SG_UNIFORMTYPE_FLOAT, SG_UNIFORMTYPE_FLOAT2,
    SG_UNIFORMTYPE_FLOAT3, SG_UNIFORMTYPE_FLOAT4, SG_UNIFORMTYPE_MAT4,
    SG_UNIFORMTYPE_NUM,
    SG_UNIFORMTYPE_FORCE_U32 = 0x7FFFFFFF

type
  sg_cull_mode* = enum
    SG_CULLMODE_DEFAULT,     ##  value 0 reserved for default-init
    SG_CULLMODE_NONE, SG_CULLMODE_FRONT, SG_CULLMODE_BACK, 
    SG_CULLMODE_NUM,
    SG_CULLMODE_FORCE_U32 = 0x7FFFFFFF

type
  sg_face_winding* = enum
    SG_FACEWINDING_DEFAULT,  ##  value 0 reserved for default-init
    SG_FACEWINDING_CCW, SG_FACEWINDING_CW, 
    SG_FACEWINDING_NUM,
    SG_FACEWINDING_FORCE_U32 = 0x7FFFFFFF

type
  sg_compare_func* = enum
    SG_COMPAREFUNC_DEFAULT,  ##  value 0 reserved for default-init
    SG_COMPAREFUNC_NEVER, SG_COMPAREFUNC_LESS, SG_COMPAREFUNC_EQUAL,
    SG_COMPAREFUNC_LESS_EQUAL, SG_COMPAREFUNC_GREATER, SG_COMPAREFUNC_NOT_EQUAL,
    SG_COMPAREFUNC_GREATER_EQUAL, SG_COMPAREFUNC_ALWAYS, 
    SG_COMPAREFUNC_NUM,
    SG_COMPAREFUNC_FORCE_U32 = 0x7FFFFFFF

type
  sg_stencil_op* = enum
    SG_STENCILOP_DEFAULT,    ##  value 0 reserved for default-init
    SG_STENCILOP_KEEP, SG_STENCILOP_ZERO, SG_STENCILOP_REPLACE,
    SG_STENCILOP_INCR_CLAMP, SG_STENCILOP_DECR_CLAMP, SG_STENCILOP_INVERT,
    SG_STENCILOP_INCR_WRAP, SG_STENCILOP_DECR_WRAP, 
    SG_STENCILOP_NUM,
    SG_STENCILOP_FORCE_U32 = 0x7FFFFFFF

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

type
  sg_blend_op* = enum
    SG_BLENDOP_DEFAULT,      ##  value 0 reserved for default-init
    SG_BLENDOP_ADD, SG_BLENDOP_SUBTRACT, SG_BLENDOP_REVERSE_SUBTRACT,
    SG_BLENDOP_NUM,
    SG_BLENDOP_FORCE_U32 = 0x7FFFFFFF

type
  sg_color_mask* = enum
    SG_COLORMASK_DEFAULT = 0,  ##  value 0 reserved for default-init
    SG_COLORMASK_R = 1, SG_COLORMASK_G = 2, SG_COLORMASK_B = 4,
    SG_COLPRMASK_RGB = 0x7,
    SG_COLORMASK_A = 8, 
    SG_COLORMASK_RGBA = 0xF,
    SG_COLORMASK_NONE = 0x10 ##  special value for 'all channels disabled
    SG_COLORMASK_FORCE_U32 = 0x7FFFFFFF

type
  action* = enum
    ACTION_DEFAULT, ACTION_CLEAR, ACTION_LOAD, ACTION_DONTCARE,
    ACTION_NUM,
    ACTION_FORCE_U32=0x7FFFFFFF

type
  color_attachment_action* {.bycopy.} = object
    action*: action
    val*: array[4, cfloat]

  depth_attachment_action* {.bycopy.} = object
    action*: action
    val*: cfloat

  stencil_attachment_action* {.bycopy.} = object
    action*: action
    val*: uint8

  pass_action* {.bycopy.} = object
    start_canary: uint32
    colors*: array[SG_MAX_COLOR_ATTACHMENTS, color_attachment_action]
    depth*: depth_attachment_action
    stencil*: stencil_attachment_action
    end_canary: uint32

type
  sg_draw_state* {.bycopy.} = object
    start_canary: uint32
    pipeline*: sg_pipeline
    vertex_buffers*: array[SG_MAX_SHADERSTAGE_BUFFERS, sg_buffer]
    index_buffer*: sg_buffer
    vs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    fs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    end_canary: uint32

type
  desc* {.bycopy.} = object
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

type
  sg_subimage_content* {.bycopy.} = object
    `ptr`*: pointer            ##  pointer to subimage data
    size*: cint                ##  size in bytes of pointed-to subimage data
  
type
  sg_image_content* {.bycopy.} = object
    subimage*: array[SG_CUBEFACE_NUM, array[SG_MAX_MIPMAPS, sg_subimage_content]]

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

proc sg_setup(desc: ptr desc) {.importc:"sg_setup",cdecl.}
proc setup*(desc: var desc) = sg_setup(addr(desc))
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
proc sg_begin_default_pass(pass_action: ptr pass_action, width: cint, height: cint) {.importc:"sg_begin_default_pass",cdecl.}
proc begin_default_pass*(pass_action: var pass_action, width: cint, height: cint) = sg_begin_default_pass(addr(pass_action), width, height)
#proc sg_begin_pass*(pass: sg_pass; pass_action: ptr pass_action)
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
