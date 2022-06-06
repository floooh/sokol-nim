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

proc c_buildPlane(buf:ptr Buffer, params:ptr Plane):Buffer {.cdecl, importc:"sshape_build_plane".}
proc buildPlane*(buf:Buffer, params:Plane):Buffer =
    c_buildPlane(unsafeAddr(buf), unsafeAddr(params))

proc c_buildBox(buf:ptr Buffer, params:ptr Box):Buffer {.cdecl, importc:"sshape_build_box".}
proc buildBox*(buf:Buffer, params:Box):Buffer =
    c_buildBox(unsafeAddr(buf), unsafeAddr(params))

proc c_buildSphere(buf:ptr Buffer, params:ptr Sphere):Buffer {.cdecl, importc:"sshape_build_sphere".}
proc buildSphere*(buf:Buffer, params:Sphere):Buffer =
    c_buildSphere(unsafeAddr(buf), unsafeAddr(params))

proc c_buildCylinder(buf:ptr Buffer, params:ptr Cylinder):Buffer {.cdecl, importc:"sshape_build_cylinder".}
proc buildCylinder*(buf:Buffer, params:Cylinder):Buffer =
    c_buildCylinder(unsafeAddr(buf), unsafeAddr(params))

proc c_buildTorus(buf:ptr Buffer, params:ptr Torus):Buffer {.cdecl, importc:"sshape_build_torus".}
proc buildTorus*(buf:Buffer, params:Torus):Buffer =
    c_buildTorus(unsafeAddr(buf), unsafeAddr(params))

proc c_planeSizes(tiles:uint32):Sizes {.cdecl, importc:"sshape_plane_sizes".}
proc planeSizes*(tiles:uint32):Sizes =
    c_planeSizes(tiles)

proc c_boxSizes(tiles:uint32):Sizes {.cdecl, importc:"sshape_box_sizes".}
proc boxSizes*(tiles:uint32):Sizes =
    c_boxSizes(tiles)

proc c_sphereSizes(slices:uint32, stacks:uint32):Sizes {.cdecl, importc:"sshape_sphere_sizes".}
proc sphereSizes*(slices:uint32, stacks:uint32):Sizes =
    c_sphereSizes(slices, stacks)

proc c_cylinderSizes(slices:uint32, stacks:uint32):Sizes {.cdecl, importc:"sshape_cylinder_sizes".}
proc cylinderSizes*(slices:uint32, stacks:uint32):Sizes =
    c_cylinderSizes(slices, stacks)

proc c_torusSizes(sides:uint32, rings:uint32):Sizes {.cdecl, importc:"sshape_torus_sizes".}
proc torusSizes*(sides:uint32, rings:uint32):Sizes =
    c_torusSizes(sides, rings)

proc c_elementRange(buf:ptr Buffer):ElementRange {.cdecl, importc:"sshape_element_range".}
proc elementRange*(buf:Buffer):ElementRange =
    c_elementRange(unsafeAddr(buf))

proc c_vertexBufferDesc(buf:ptr Buffer):gfx.BufferDesc {.cdecl, importc:"sshape_vertex_buffer_desc".}
proc vertexBufferDesc*(buf:Buffer):gfx.BufferDesc =
    c_vertexBufferDesc(unsafeAddr(buf))

proc c_indexBufferDesc(buf:ptr Buffer):gfx.BufferDesc {.cdecl, importc:"sshape_index_buffer_desc".}
proc indexBufferDesc*(buf:Buffer):gfx.BufferDesc =
    c_indexBufferDesc(unsafeAddr(buf))

proc c_bufferLayoutDesc():gfx.BufferLayoutDesc {.cdecl, importc:"sshape_buffer_layout_desc".}
proc bufferLayoutDesc*():gfx.BufferLayoutDesc =
    c_bufferLayoutDesc()

proc c_positionAttrDesc():gfx.VertexAttrDesc {.cdecl, importc:"sshape_position_attr_desc".}
proc positionAttrDesc*():gfx.VertexAttrDesc =
    c_positionAttrDesc()

proc c_normalAttrDesc():gfx.VertexAttrDesc {.cdecl, importc:"sshape_normal_attr_desc".}
proc normalAttrDesc*():gfx.VertexAttrDesc =
    c_normalAttrDesc()

proc c_texcoordAttrDesc():gfx.VertexAttrDesc {.cdecl, importc:"sshape_texcoord_attr_desc".}
proc texcoordAttrDesc*():gfx.VertexAttrDesc =
    c_texcoordAttrDesc()

proc c_colorAttrDesc():gfx.VertexAttrDesc {.cdecl, importc:"sshape_color_attr_desc".}
proc colorAttrDesc*():gfx.VertexAttrDesc =
    c_colorAttrDesc()

proc c_color4f(r:cfloat, g:cfloat, b:cfloat, a:cfloat):uint32 {.cdecl, importc:"sshape_color_4f".}
proc color4f*(r:cfloat, g:cfloat, b:cfloat, a:cfloat):uint32 =
    c_color4f(r, g, b, a)

proc c_color3f(r:cfloat, g:cfloat, b:cfloat):uint32 {.cdecl, importc:"sshape_color_3f".}
proc color3f*(r:cfloat, g:cfloat, b:cfloat):uint32 =
    c_color3f(r, g, b)

proc c_color4b(r:uint8, g:uint8, b:uint8, a:uint8):uint32 {.cdecl, importc:"sshape_color_4b".}
proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):uint32 =
    c_color4b(r, g, b, a)

proc c_color3b(r:uint8, g:uint8, b:uint8):uint32 {.cdecl, importc:"sshape_color_3b".}
proc color3b*(r:uint8, g:uint8, b:uint8):uint32 =
    c_color3b(r, g, b)

proc c_mat4(m:ptr cfloat):Mat4 {.cdecl, importc:"sshape_mat4".}
proc mat4*(m:ptr cfloat):Mat4 =
    c_mat4(m)

proc c_mat4Transpose(m:ptr cfloat):Mat4 {.cdecl, importc:"sshape_mat4_transpose".}
proc mat4Transpose*(m:ptr cfloat):Mat4 =
    c_mat4Transpose(m)

# Nim-specific API extensions
include extra/shape
