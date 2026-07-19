## machine generated, do not edit

import gfx

type Range* = object
  `addr`*:pointer
  size*:int

const
  minVertexSize* = 12
  maxVertexSize* = 24

type Mat4* = object
  m*:array[4, array[4, float32]]

converter toMat4m*[Y:static[int], X:static[int]](items: array[Y, array[X, float32]]): array[4, array[4, float32]] =
  static: assert(X <= 4)
  static: assert(Y <= 4)
  for indexY,itemY in items.pairs:
    for indexX, itemX in itemY.pairs:
      result[indexY][indexX] = itemX

type OptionalComponents* = object
  normals*:bool
  texcoords*:bool
  colors*:bool

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

type State* = object
  valid*:bool
  disable*:OptionalComponents
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

proc c_buildPlane(state:ptr State, params:ptr Plane):void {.cdecl, importc:"sshape_build_plane".}
proc buildPlane*(state:ptr State, params:Plane):void =
    c_buildPlane(state, addr(params))

proc c_buildBox(state:ptr State, params:ptr Box):void {.cdecl, importc:"sshape_build_box".}
proc buildBox*(state:ptr State, params:Box):void =
    c_buildBox(state, addr(params))

proc c_buildSphere(state:ptr State, params:ptr Sphere):void {.cdecl, importc:"sshape_build_sphere".}
proc buildSphere*(state:ptr State, params:Sphere):void =
    c_buildSphere(state, addr(params))

proc c_buildCylinder(state:ptr State, params:ptr Cylinder):void {.cdecl, importc:"sshape_build_cylinder".}
proc buildCylinder*(state:ptr State, params:Cylinder):void =
    c_buildCylinder(state, addr(params))

proc c_buildTorus(state:ptr State, params:ptr Torus):void {.cdecl, importc:"sshape_build_torus".}
proc buildTorus*(state:ptr State, params:Torus):void =
    c_buildTorus(state, addr(params))

proc c_vertexSize(components:ptr OptionalComponents):int {.cdecl, importc:"sshape_vertex_size".}
proc vertexSize*(components:OptionalComponents):int =
    c_vertexSize(addr(components))

proc c_planeSizes(tiles:uint32, vertexSize:int):Sizes {.cdecl, importc:"sshape_plane_sizes".}
proc planeSizes*(tiles:uint32, vertexSize:int):Sizes =
    c_planeSizes(tiles, vertex_size)

proc c_boxSizes(tiles:uint32, vetrexSize:int):Sizes {.cdecl, importc:"sshape_box_sizes".}
proc boxSizes*(tiles:uint32, vetrexSize:int):Sizes =
    c_boxSizes(tiles, vetrex_size)

proc c_sphereSizes(slices:uint32, stacks:uint32, vertexSize:int):Sizes {.cdecl, importc:"sshape_sphere_sizes".}
proc sphereSizes*(slices:uint32, stacks:uint32, vertexSize:int):Sizes =
    c_sphereSizes(slices, stacks, vertex_size)

proc c_cylinderSizes(slices:uint32, stacks:uint32, vertexSize:int):Sizes {.cdecl, importc:"sshape_cylinder_sizes".}
proc cylinderSizes*(slices:uint32, stacks:uint32, vertexSize:int):Sizes =
    c_cylinderSizes(slices, stacks, vertex_size)

proc c_torusSizes(sides:uint32, rings:uint32, vertexSize:int):Sizes {.cdecl, importc:"sshape_torus_sizes".}
proc torusSizes*(sides:uint32, rings:uint32, vertexSize:int):Sizes =
    c_torusSizes(sides, rings, vertex_size)

proc c_elementRange(state:ptr State):ElementRange {.cdecl, importc:"sshape_element_range".}
proc elementRange*(state:State):ElementRange =
    c_elementRange(addr(state))

proc c_vertexBufferDesc(state:ptr State):gfx.BufferDesc {.cdecl, importc:"sshape_vertex_buffer_desc".}
proc vertexBufferDesc*(state:State):gfx.BufferDesc =
    c_vertexBufferDesc(addr(state))

proc c_indexBufferDesc(state:ptr State):gfx.BufferDesc {.cdecl, importc:"sshape_index_buffer_desc".}
proc indexBufferDesc*(state:State):gfx.BufferDesc =
    c_indexBufferDesc(addr(state))

proc c_vertexBufferLayoutState(state:ptr State):gfx.VertexBufferLayoutState {.cdecl, importc:"sshape_vertex_buffer_layout_state".}
proc vertexBufferLayoutState*(state:State):gfx.VertexBufferLayoutState =
    c_vertexBufferLayoutState(addr(state))

proc c_positionVertexAttrState(state:ptr State):gfx.VertexAttrState {.cdecl, importc:"sshape_position_vertex_attr_state".}
proc positionVertexAttrState*(state:State):gfx.VertexAttrState =
    c_positionVertexAttrState(addr(state))

proc c_normalVertexAttrState(state:ptr State):gfx.VertexAttrState {.cdecl, importc:"sshape_normal_vertex_attr_state".}
proc normalVertexAttrState*(state:State):gfx.VertexAttrState =
    c_normalVertexAttrState(addr(state))

proc c_texcoordVertexAttrState(state:ptr State):gfx.VertexAttrState {.cdecl, importc:"sshape_texcoord_vertex_attr_state".}
proc texcoordVertexAttrState*(state:State):gfx.VertexAttrState =
    c_texcoordVertexAttrState(addr(state))

proc c_colorVertexAttrState(state:ptr State):gfx.VertexAttrState {.cdecl, importc:"sshape_color_vertex_attr_state".}
proc colorVertexAttrState*(state:State):gfx.VertexAttrState =
    c_colorVertexAttrState(addr(state))

proc c_color4f(r:float32, g:float32, b:float32, a:float32):uint32 {.cdecl, importc:"sshape_color_4f".}
proc color4f*(r:float32, g:float32, b:float32, a:float32):uint32 =
    c_color4f(r, g, b, a)

proc c_color3f(r:float32, g:float32, b:float32):uint32 {.cdecl, importc:"sshape_color_3f".}
proc color3f*(r:float32, g:float32, b:float32):uint32 =
    c_color3f(r, g, b)

proc c_color4b(r:uint8, g:uint8, b:uint8, a:uint8):uint32 {.cdecl, importc:"sshape_color_4b".}
proc color4b*(r:uint8, g:uint8, b:uint8, a:uint8):uint32 =
    c_color4b(r, g, b, a)

proc c_color3b(r:uint8, g:uint8, b:uint8):uint32 {.cdecl, importc:"sshape_color_3b".}
proc color3b*(r:uint8, g:uint8, b:uint8):uint32 =
    c_color3b(r, g, b)

proc c_mat4(m:ptr float32):Mat4 {.cdecl, importc:"sshape_mat4".}
proc mat4*(m:ptr float32):Mat4 =
    c_mat4(m)

proc c_mat4Transpose(m:ptr float32):Mat4 {.cdecl, importc:"sshape_mat4_transpose".}
proc mat4Transpose*(m:ptr float32):Mat4 =
    c_mat4Transpose(m)

{.passc:"-DIMPL".}
when defined(release):
  {.passc:"-DNDEBUG".}
{.compile:"c/sokol_shape.c".}
