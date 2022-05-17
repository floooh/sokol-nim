## machine generated, do not edit

import gfx

type Range* = object
  `ptr`*:pointer
  size*:csize_t

type Mat4* = object
  m*:array[4, array[4, cfloat]]

type Vertex* = object
  x*:cfloat
  y*:cfloat
  z*:cfloat
  normal*:uint32
  u*:uint16
  v*:uint16
  color*:uint32

type ElementRange* = object
  baseElement*:cint
  numElements*:cint

type SizesItem* = object
  num*:uint32
  size*:uint32

type Sizes* = object
  vertices*:SizesItem
  indices*:SizesItem

type BufferItem* = object
  buffer*:Range
  dataSize*:csize_t
  shapeOffset*:csize_t

type Buffer* = object
  valid*:bool
  vertices*:BufferItem
  indices*:BufferItem

type Plane* = object
  width*:cfloat
  depth*:cfloat
  tiles*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Box* = object
  width*:cfloat
  height*:cfloat
  depth*:cfloat
  tiles*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Sphere* = object
  radius*:cfloat
  slices*:uint16
  stacks*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Cylinder* = object
  radius*:cfloat
  height*:cfloat
  slices*:uint16
  stacks*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Torus* = object
  radius*:cfloat
  ringRadius*:cfloat
  sides*:uint16
  rings*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

proc buildPlane*(buf:ptr Buffer, params:ptr Plane):Buffer {.cdecl, importc:"sshape_build_plane".}

proc buildBox*(buf:ptr Buffer, params:ptr Box):Buffer {.cdecl, importc:"sshape_build_box".}

proc buildSphere*(buf:ptr Buffer, params:ptr Sphere):Buffer {.cdecl, importc:"sshape_build_sphere".}

proc buildCylinder*(buf:ptr Buffer, params:ptr Cylinder):Buffer {.cdecl, importc:"sshape_build_cylinder".}

proc buildTorus*(buf:ptr Buffer, params:ptr Torus):Buffer {.cdecl, importc:"sshape_build_torus".}

proc planeSizes*(tiles:uint32):Sizes {.cdecl, importc:"sshape_plane_sizes".}

proc boxSizes*(tiles:uint32):Sizes {.cdecl, importc:"sshape_box_sizes".}

proc sphereSizes*(slices:uint32, stacks:uint32):Sizes {.cdecl, importc:"sshape_sphere_sizes".}

proc cylinderSizes*(slices:uint32, stacks:uint32):Sizes {.cdecl, importc:"sshape_cylinder_sizes".}

proc torusSizes*(sides:uint32, rings:uint32):Sizes {.cdecl, importc:"sshape_torus_sizes".}

proc elementRange*(buf:ptr Buffer):ElementRange {.cdecl, importc:"sshape_element_range".}

proc vertexBufferDesc*(buf:ptr Buffer):gfx.BufferDesc {.cdecl, importc:"sshape_vertex_buffer_desc".}

proc indexBufferDesc*(buf:ptr Buffer):gfx.BufferDesc {.cdecl, importc:"sshape_index_buffer_desc".}

proc bufferLayoutDesc*():gfx.BufferLayoutDesc {.cdecl, importc:"sshape_buffer_layout_desc".}

proc positionAttrDesc*():gfx.VertexAttrDesc {.cdecl, importc:"sshape_position_attr_desc".}

proc normalAttrDesc*():gfx.VertexAttrDesc {.cdecl, importc:"sshape_normal_attr_desc".}

proc texcoordAttrDesc*():gfx.VertexAttrDesc {.cdecl, importc:"sshape_texcoord_attr_desc".}

proc colorAttrDesc*():gfx.VertexAttrDesc {.cdecl, importc:"sshape_color_attr_desc".}

proc color4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):uint32 {.cdecl, importc:"sshape_color_4f".}

proc color3f*(r:cfloat, g:cfloat, b:cfloat):uint32 {.cdecl, importc:"sshape_color_3f".}

proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):uint32 {.cdecl, importc:"sshape_color_4b".}

proc color3b*(r:uint8, g:uint8, b:uint8):uint32 {.cdecl, importc:"sshape_color_3b".}

proc mat4*(m:ptr cfloat):Mat4 {.cdecl, importc:"sshape_mat4".}

proc mat4Transpose*(m:ptr cfloat):Mat4 {.cdecl, importc:"sshape_mat4_transpose".}

# Nim-specific API extensions
include extra/shape
