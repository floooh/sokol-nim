#-------------------------------------------------------------------------------
#   sgl-point-sapp.c
#
#   Test point rendering with sokol/gl
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sgl
import sokol/glue as sglue
import std/math

type Rgb = object
  r, g, b: float32

const palette = [
    Rgb(r:0.957, g:0.263, b:0.212),
    Rgb(r:0.914, g:0.118, b:0.388),
    Rgb(r:0.612, g:0.153, b:0.690),
    Rgb(r:0.404, g:0.227, b:0.718),
    Rgb(r:0.247, g:0.318, b:0.710),
    Rgb(r:0.129, g:0.588, b:0.953),
    Rgb(r:0.012, g:0.663, b:0.957),
    Rgb(r:0.000, g:0.737, b:0.831),
    Rgb(r:0.000, g:0.588, b:0.533),
    Rgb(r:0.298, g:0.686, b:0.314),
    Rgb(r:0.545, g:0.765, b:0.290),
    Rgb(r:0.804, g:0.863, b:0.224),
    Rgb(r:1.000, g:0.922, b:0.231),
    Rgb(r:1.000, g:0.757, b:0.027),
    Rgb(r:1.000, g:0.596, b:0.000),
    Rgb(r:1.000, g:0.341, b:0.133),
]

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))
  sgl.setup(sgl.Desc())

proc lerp(x0: float32, x1: float32, t: float32): float32 =
  return x0 * (1f - t) + (x1 * t)

proc lerp(c0: Rgb, c1: Rgb, t: float32): Rgb =
  return Rgb(r: lerp(c0.r, c1.r, t), g: lerp(c0.g, c1.g, t), b: lerp(c0.b, c1.b, t))

proc computeColor(t: float32): Rgb =
  let i0 = (t * 16).int mod 16
  let i1 = (i0 + 1) mod 16
  let l = t * 16f mod 1f
  return lerp(palette[i0], palette[i1], l)

proc frame() {.cdecl.} =
  let frameCount = sapp.frameCount().int
  let angle = frameCount.float32 mod 360f

  sgl.defaults()
  sgl.beginPoints()
  var psize = 5f
  for i in 0..<360:
    let a = sgl.asRadians(angle + i.float32)
    let color = computeColor(((frameCount + i).float32 mod 300f) / 300f)
    let r = sin(a * 4)
    let s = sin(a)
    let c = cos(a)
    let x = s * r
    let y = c * r
    sgl.c3f(color.r, color.g, color.b)
    sgl.pointSize(psize)
    sgl.v2f(x, y)
    psize *= 1.005
  sgl.end()

  const passAction = PassAction(
    colors: [ ColorAttachmentAction(action: actionClear, value: (0, 0, 0, 1)) ]
  )
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sgl.draw()
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sgl.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 512,
  height: 512,
  windowTitle: "sglpoints.nim"
))
