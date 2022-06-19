type Vec2* = object
  x*: float32
  y*: float32

proc vec2*(): Vec2 =
  result = Vec2(x:0f, y:0f)

proc vec2*(x: float32, y: float32): Vec2 =
  result = Vec2(x: x, y: y)

proc zero*(): Vec2 =
  result = Vec2(x:0f, y:0f)

proc `+`*(v0: Vec2, v1: Vec2): Vec2 =
    result = Vec2(x: v0.x+v1.x, y: v0.y+v1.y)
