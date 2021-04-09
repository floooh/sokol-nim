## machine generated, do not edit

import gfx

type Range* = object
  source*:pointer
  size*:int

type Mat4* = object
  m*:array[4, array[4, float32]]

type Vertex* = object
  x*:float32
  y*:float32
  z*:float32
  normal*:uint32
  u*:uint16
  v*:uint16
  color*:uint32

type ElementRange* = object
  baseElement*:int32
  numElements*:int32

type SizesItem* = object
  num*:uint32
  size*:uint32

type Sizes* = object
  vertices*:SizesItem
  indices*:SizesItem

type BufferItem* = object
  buffer*:Range
  dataSize*:int
  shapeOffset*:int

type Buffer* = object
  valid*:bool
  vertices*:BufferItem
  indices*:BufferItem

type Plane* = object
  width*:float32
  depth*:float32
  tiles*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Box* = object
  width*:float32
  height*:float32
  depth*:float32
  tiles*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Sphere* = object
  radius*:float32
  slices*:uint16
  stacks*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Cylinder* = object
  radius*:float32
  height*:float32
  slices*:uint16
  stacks*:uint16
  color*:uint32
  randomColors*:bool
  merge*:bool
  transform*:Mat4

type Torus* = object
  radius*:float32
  ringRadius*:float32
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

proc vertexBufferDesc*(buf:ptr Buffer):sg.BufferDesc {.cdecl, importc:"sshape_vertex_buffer_desc".}

proc indexBufferDesc*(buf:ptr Buffer):sg.BufferDesc {.cdecl, importc:"sshape_index_buffer_desc".}

proc bufferLayoutDesc*():sg.BufferLayoutDesc {.cdecl, importc:"sshape_buffer_layout_desc".}

proc positionAttrDesc*():sg.VertexAttrDesc {.cdecl, importc:"sshape_position_attr_desc".}

proc normalAttrDesc*():sg.VertexAttrDesc {.cdecl, importc:"sshape_normal_attr_desc".}

proc texcoordAttrDesc*():sg.VertexAttrDesc {.cdecl, importc:"sshape_texcoord_attr_desc".}

proc colorAttrDesc*():sg.VertexAttrDesc {.cdecl, importc:"sshape_color_attr_desc".}

proc color4f*(r:float32, g:float32, b:float32, a:float32):uint32 {.cdecl, importc:"sshape_color_4f".}

proc color3f*(r:float32, g:float32, b:float32):uint32 {.cdecl, importc:"sshape_color_3f".}

proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):uint32 {.cdecl, importc:"sshape_color_4b".}

proc color3b*(r:uint8, g:uint8, b:uint8):uint32 {.cdecl, importc:"sshape_color_3b".}

proc mat4*(m:ptr float32):Mat4 {.cdecl, importc:"sshape_mat4".}

proc mat4Transpose*(m:ptr float32):Mat4 {.cdecl, importc:"sshape_mat4_transpose".}

# Nim-specific API extensions
include nim/shape
