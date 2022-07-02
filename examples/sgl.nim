#-------------------------------------------------------------------------------
# sgl.nim
# Rendering via sokol/gl
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sgl
import sokol/glue as sglue
import std/math

const
  passAction = PassAction(
    colors: [ ColorAttachmentAction(action: actionClear, value: (0, 0, 0, 1))]
  )

var
  img: sg.Image
  pip3d: sgl.Pipeline

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: sglue.context()))
  sgl.setup(sgl.Desc())

  # a checkerboard texture
  const imgWidth = 8
  const imgHeight = 8
  var pixels: array[imgHeight, array[imgWidth, uint32]]
  for y in 0..<imgHeight:
    for x in 0..<imgWidth:
      pixels[y][x] = if 0 != ((y xor x) and 1): 0xFFFFFFFF'u32 else: 0xFF000000'u32
  img = sg.makeImage(sg.ImageDesc(
    width: imgWidth,
    height: imgHeight,
    data: sg.ImageData(
      subimage: [ [ sg.Range(addr: pixels.unsafeAddr, size: pixels.sizeof) ] ]
    )
  ))

  # create a pipeline object for 3d rendering, with less-equal
  # depth-test and cull-face enabled, note that we don't provide
  # a shader, vertex-layout, pixel formats and sample count here,
  # these are all filled in by sokol/gl
  pip3d = sgl.makePipeline(sg.PipelineDesc(
    cullMode: cullModeBack,
    depth: DepthState(
      writeEnabled: true,
      compare: compareFuncLessEqual,
    )
  ))

proc drawTriangle() =
  sgl.defaults()
  sgl.beginTriangles()
  sgl.v2fC3b( 0.0,  0.5, 255, 0, 0)
  sgl.v2fC3b(-0.5, -0.5, 0, 0, 255)
  sgl.v2fC3b( 0.5, -0.5, 0, 255, 0)
  sgl.end()

proc drawQuad(t: float32) =
  var angleDeg {.global.} = 0f
  let scale = 1f + math.sin(sgl.asRadians(angleDeg)) * 0.5
  angleDeg += t
  sgl.defaults()
  sgl.rotate(sgl.asRadians(angleDeg), 0, 0, 1)
  sgl.scale(scale, scale, 1)
  sgl.beginQuads()
  sgl.v2fC3b(-0.5, -0.5, 255, 255, 0)
  sgl.v2fC3b( 0.5, -0.5, 0, 255, 0)
  sgl.v2fC3b( 0.5,  0.5, 0, 0, 255)
  sgl.v2fC3b(-0.5,  0.5, 255, 0, 0)
  sgl.end()

# vertex specification for a cube with colored sides and texture coords
proc cube() =
  sgl.beginQuads()
  sgl.c3f(1, 0, 0)
  sgl.v3fT2f(-1,  1, -1, -1,  1)
  sgl.v3fT2f( 1,  1, -1,  1,  1)
  sgl.v3fT2f( 1, -1, -1,  1, -1)
  sgl.v3fT2f(-1, -1, -1, -1, -1)
  sgl.c3f(0, 1, 0)
  sgl.v3fT2f(-1, -1,  1, -1,  1)
  sgl.v3fT2f( 1, -1,  1,  1,  1)
  sgl.v3fT2f( 1,  1,  1,  1, -1)
  sgl.v3fT2f(-1,  1,  1, -1, -1)
  sgl.c3f(0, 0, 1)
  sgl.v3fT2f(-1, -1,  1, -1,  1)
  sgl.v3fT2f(-1,  1,  1,  1,  1)
  sgl.v3fT2f(-1,  1, -1,  1, -1)
  sgl.v3fT2f(-1, -1, -1, -1, -1)
  sgl.c3f(1, 0.5, 0)
  sgl.v3fT2f( 1, -1,  1, -1,  1)
  sgl.v3fT2f( 1, -1, -1,  1,  1)
  sgl.v3fT2f( 1,  1, -1,  1, -1)
  sgl.v3fT2f( 1,  1,  1, -1, -1)
  sgl.c3f(0, 0.5, 1)
  sgl.v3fT2f( 1, -1, -1, -1,  1)
  sgl.v3fT2f( 1, -1,  1,  1,  1)
  sgl.v3fT2f(-1, -1,  1,  1, -1)
  sgl.v3fT2f(-1, -1, -1, -1, -1)
  sgl.c3f(1, 0, 0.5)
  sgl.v3fT2f(-1,  1, -1, -1,  1)
  sgl.v3fT2f(-1,  1,  1,  1,  1)
  sgl.v3fT2f( 1,  1,  1,  1, -1)
  sgl.v3fT2f( 1,  1, -1, -1, -1)
  sgl.end()

template withPushPopMatrix(body: untyped) =
  sgl.pushMatrix()
  body
  sgl.popMatrix()

proc drawCubes(t: float32) =
    var rot {.global.} = [0'f32, 0]
    rot[0] += 1f * t
    rot[1] += 2f * t

    sgl.defaults()
    sgl.loadPipeline(pip3d)

    sgl.matrixModeProjection()
    sgl.perspective(sgl.asRadians(45), 1, 0.1, 100.0)

    sgl.matrixModeModelview()
    sgl.translate(0, 0, -12)
    sgl.rotate(sgl.asRadians(rot[0]), 1, 0, 0)
    sgl.rotate(sgl.asRadians(rot[1]), 0, 1, 0)
    cube()
    withPushPopMatrix:
        sgl.translate(0, 0, 3)
        sgl.scale(0.5, 0.5, 0.5)
        sgl.rotate(-2 * sgl.asRadians(rot[0]), 1, 0, 0)
        sgl.rotate(-2 * sgl.asRadians(rot[1]), 0, 1, 0)
        cube()
        withPushPopMatrix:
            sgl.translate(0, 0, 3)
            sgl.scale(0.5, 0.5, 0.5)
            sgl.rotate(-3 * sgl.asRadians(2*rot[0]), 1, 0, 0)
            sgl.rotate(3 * sgl.asRadians(2*rot[1]), 0, 0, 1)
            cube()

proc drawTexCube(t: float32) =
    let a = sgl.asRadians(sapp.frameCount().float32 * t)

    # texture matrix rotation and scale
    let texRot = 0.5 * a
    let texScale = 1.0 + math.sin(a) * 0.5

    # compute an orbiting eye-position for testing sgl.lookat()
    let eyeX = math.sin(a) * 6
    let eyeZ = math.cos(a) * 6
    let eyeY = math.sin(a) * 3

    sgl.defaults()
    sgl.loadPipeline(pip3d)

    sgl.enableTexture()
    sgl.texture(img)

    sgl.matrixModeProjection()
    sgl.perspective(sgl.asRadians(45), 1, 0.1, 100)
    sgl.matrixModeModelview()
    sgl.lookat(eyeX, eyeY, eyeZ, 0, 0, 0, 0, 1, 0)
    sgl.matrixModeTexture()
    sgl.rotate(texRot, 0, 0, 1)
    sgl.scale(texScale, texScale, 1)
    cube()

proc frame() {.cdecl.} =
  let t = sapp.frameDuration() * 60f

  # compute viewport rectangles so that the views are horizontally
  # centered and keep a 1:1 aspect ratio
  let dw = sapp.widthf()
  let dh = sapp.heightf()
  let ww = dh / 2 # not a bug
  let hh = dh / 2
  let x0 = dw / 2 - hh
  let x1 = dw / 2
  let y0 = 0f
  let y1 = dh / 2

  # all sokol-gl functions except sgl_draw() can be called anywhere in the frame
  sgl.viewportf(x0, y0, ww, hh, true)
  drawTriangle()
  sgl.viewportf(x1, y0, ww, hh, true)
  drawQuad(t)
  sgl.viewportf(x0, y1, ww, hh, true)
  drawCubes(t)
  sgl.viewportf(x1, y1, ww, hh, true)
  drawTexCube(t)
  sgl.viewportf(0, 0, dw, dh, true)

  # Render the sokol-gfx default pass, all sokol-gl commands
  # that happened so far are rendered inside sgl_draw(), and this
  # is the only sokol-gl function that must be called inside
  # a sokol-gfx begin/end pass pair.
  # sgl_draw() also 'rewinds' sokol-gl for the next frame.
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
  sampleCount: 4,
  windowTitle: "sgl.nim",
  icon: IconDesc(sokol_default: true)
))
