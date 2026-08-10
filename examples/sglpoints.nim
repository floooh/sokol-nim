#-------------------------------------------------------------------------------
#   sgl-point-sapp.c
#
#   Test point rendering with sokol/gl
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sgl
import sokol/glue as sglue
import std/math

type Rgb = object
  r, g, b: float32

const palette = [
    Rgb(r:0.957f, g:0.263f, b:0.212f),
    Rgb(r:0.914f, g:0.118f, b:0.388f),
    Rgb(r:0.612f, g:0.153f, b:0.690f),
    Rgb(r:0.404f, g:0.227f, b:0.718f),
    Rgb(r:0.247f, g:0.318f, b:0.710f),
    Rgb(r:0.129f, g:0.588f, b:0.953f),
    Rgb(r:0.012f, g:0.663f, b:0.957f),
    Rgb(r:0.000f, g:0.737f, b:0.831f),
    Rgb(r:0.000f, g:0.588f, b:0.533f),
    Rgb(r:0.298f, g:0.686f, b:0.314f),
    Rgb(r:0.545f, g:0.765f, b:0.290f),
    Rgb(r:0.804f, g:0.863f, b:0.224f),
    Rgb(r:1.000f, g:0.922f, b:0.231f),
    Rgb(r:1.000f, g:0.757f, b:0.027f),
    Rgb(r:1.000f, g:0.596f, b:0.000f),
    Rgb(r:1.000f, g:0.341f, b:0.133f),
]

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))
  sgl.setup(sgl.Desc(
    logger: sgl.Logger(fn: slog.fn)
  ))

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
  let angle = frameCount.float32 mod 360.0f

  sgl.defaults()
  sgl.beginPoints()
  var psize = 5.0f
  for i in 0..<360:
    let a = sgl.asRadians(angle + i.float32)
    let color = computeColor(((frameCount + i).float32 mod 300.0f) / 300.0f)
    let r = sin(a * 4.0f)
    let s = sin(a)
    let c = cos(a)
    let x = s * r
    let y = c * r
    sgl.c3f(color.r, color.g, color.b)
    sgl.pointSize(psize)
    sgl.v2f(x, y)
    psize *= 1.005f
  sgl.end()

  var passAction: PassAction
  passAction.colors[0] = ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.0f, 0.0f, 0.0f, 1.0f))
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
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
  windowTitle: "sglpoints.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
