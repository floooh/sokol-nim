#-------------------------------------------------------------------------------
# sgl.nim
# Rendering via sokol/gl
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sogl
import sokol/glue as sglue
import std/math

let
  passAction = block:
    var tmp = sg.PassAction()
    tmp.colors[0] = sg.ColorAttachmentAction(loadAction: sg.loadActionClear, clearValue: (0, 0, 0, 1))
    tmp

var
  texView: sg.View
  smp: sg.Sampler
  pip3d: sogl.Pipeline

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))
  sogl.setup(sogl.Desc(
    logger: sogl.Logger(fn: slog.fn),
  ))

  # a checkerboard image and texture view
  const imgWidth = 4
  const imgHeight = 4
  let pixels = [
    0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32,
    0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32,
    0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32,
    0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32,
  ]
  var mipLevels: array[16, sg.Range] = default(array[16, sg.Range])
  mipLevels[0] = sg.Range(addr: pixels.addr, size: pixels.sizeof)
  texView = sg.makeView(sg.ViewDesc(
    texture: sg.TextureViewDesc(
      image: sg.makeImage(sg.ImageDesc(
        width: imgWidth.int32,
        height: imgHeight.int32,
        data: sg.ImageData(
          mipLevels: mipLevels
        )
      ))
    )
  ))

  # and a sampler
  smp = sg.makeSampler(sg.SamplerDesc(
    minFilter: sg.filterNearest,
    magFilter: sg.filterNearest,
  ))

  # create a pipeline object for 3d rendering, with less-equal
  # depth-test and cull-face enabled, note that we don't provide
  # a shader, vertex-layout, pixel formats and sample count here,
  # these are all filled in by sokol/gl
  pip3d = sogl.makePipeline(sg.PipelineDesc(
    cullMode: sg.cullModeBack,
    depth: sg.DepthState(
      writeEnabled: true,
      compare: sg.compareFuncLessEqual,
    )
  ))

proc drawTriangle() =
  sogl.defaults()
  sogl.beginTriangles()
  sogl.v2fC3b( 0.0,  0.5, 255, 0, 0)
  sogl.v2fC3b(-0.5, -0.5, 0, 0, 255)
  sogl.v2fC3b( 0.5, -0.5, 0, 255, 0)
  sogl.end()

proc drawQuad(t: float32) =
  var angleDeg {.global.} = 0f
  let scale = 1f + math.sin(sogl.asRadians(angleDeg)) * 0.5
  angleDeg += t
  sogl.defaults()
  sogl.rotate(sogl.asRadians(angleDeg), 0, 0, 1)
  sogl.scale(scale, scale, 1)
  sogl.beginQuads()
  sogl.v2fC3b(-0.5, -0.5, 255, 255, 0)
  sogl.v2fC3b( 0.5, -0.5, 0, 255, 0)
  sogl.v2fC3b( 0.5,  0.5, 0, 0, 255)
  sogl.v2fC3b(-0.5,  0.5, 255, 0, 0)
  sogl.end()

# vertex specification for a cube with colored sides and texture coords
proc cube() =
  sogl.beginQuads()
  sogl.c3f(1.0f, 0.0f, 0.0f)
  sogl.v3fT2f(-1.0f,  1.0f, -1.0f, -1.0f,  1.0f)
  sogl.v3fT2f( 1.0f,  1.0f, -1.0f,  1.0f,  1.0f)
  sogl.v3fT2f( 1.0f, -1.0f, -1.0f,  1.0f, -1.0f)
  sogl.v3fT2f(-1.0f, -1.0f, -1.0f, -1.0f, -1.0f)
  sogl.c3f(0.0f, 1.0f, 0.0f)
  sogl.v3fT2f(-1.0f, -1.0f,  1.0f, -1.0f,  1.0f)
  sogl.v3fT2f( 1.0f, -1.0f,  1.0f,  1.0f,  1.0f)
  sogl.v3fT2f( 1.0f,  1.0f,  1.0f,  1.0f, -1.0f)
  sogl.v3fT2f(-1.0f,  1.0f,  1.0f, -1.0f, -1.0f)
  sogl.c3f(0.0f, 0.0f, 1.0f)
  sogl.v3fT2f(-1.0f, -1.0f,  1.0f, -1.0f,  1.0f)
  sogl.v3fT2f(-1.0f,  1.0f,  1.0f,  1.0f,  1.0f)
  sogl.v3fT2f(-1.0f,  1.0f, -1.0f,  1.0f, -1.0f)
  sogl.v3fT2f(-1.0f, -1.0f, -1.0f, -1.0f, -1.0f)
  sogl.c3f(1.0f, 0.5f, 0.0f)
  sogl.v3fT2f( 1.0f, -1.0f,  1.0f, -1.0f,  1.0f)
  sogl.v3fT2f( 1.0f, -1.0f, -1.0f,  1.0f,  1.0f)
  sogl.v3fT2f( 1.0f,  1.0f, -1.0f,  1.0f, -1.0f)
  sogl.v3fT2f( 1.0f,  1.0f,  1.0f, -1.0f, -1.0f)
  sogl.c3f(0.0f, 0.5f, 1.0f)
  sogl.v3fT2f( 1.0f, -1.0f, -1.0f, -1.0f,  1.0f)
  sogl.v3fT2f( 1.0f, -1.0f,  1.0f,  1.0f,  1.0f)
  sogl.v3fT2f(-1.0f, -1.0f,  1.0f,  1.0f, -1.0f)
  sogl.v3fT2f(-1.0f, -1.0f, -1.0f, -1.0f, -1.0f)
  sogl.c3f(1.0f, 0.0f, 0.5f)
  sogl.v3fT2f(-1.0f,  1.0f, -1.0f, -1.0f,  1.0f)
  sogl.v3fT2f(-1.0f,  1.0f,  1.0f,  1.0f,  1.0f)
  sogl.v3fT2f( 1.0f,  1.0f,  1.0f,  1.0f, -1.0f)
  sogl.v3fT2f( 1.0f,  1.0f, -1.0f, -1.0f, -1.0f)
  sogl.end()

template withPushPopMatrix(body: untyped) =
  sogl.pushMatrix()
  body
  sogl.popMatrix()

proc drawCubes(t: float32) =
    var rot {.global.} = [0'f32, 0]
    rot[0] += 1f * t
    rot[1] += 2f * t

    sogl.defaults()
    sogl.loadPipeline(pip3d)

    sogl.matrixModeProjection()
    sogl.perspective(sogl.asRadians(45.0f), 1.0f, 0.1f, 100.0f)

    sogl.matrixModeModelview()
    sogl.translate(0.0f, 0.0f, -12.0f)
    sogl.rotate(sogl.asRadians(rot[0]), 1.0f, 0.0f, 0.0f)
    sogl.rotate(sogl.asRadians(rot[1]), 0.0f, 1.0f, 0.0f)
    cube()
    withPushPopMatrix:
        sogl.translate(0.0f, 0.0f, 3.0f)
        sogl.scale(0.5f, 0.5f, 0.5f)
        sogl.rotate(-2.0f * sogl.asRadians(rot[0]), 1.0f, 0.0f, 0.0f)
        sogl.rotate(-2.0f * sogl.asRadians(rot[1]), 0.0f, 1.0f, 0.0f)
        cube()
        withPushPopMatrix:
            sogl.translate(0.0f, 0.0f, 3.0f)
            sogl.scale(0.5f, 0.5f, 0.5f)
            sogl.rotate(-3.0f * sogl.asRadians(2.0f*rot[0]), 1.0f, 0.0f, 0.0f)
            sogl.rotate(3.0f * sogl.asRadians(2.0f*rot[1]), 0.0f, 0.0f, 1.0f)
            cube()

proc drawTexCube(t: float32) =
    let a = sogl.asRadians(sapp.frameCount().float32 * t)

    # texture matrix rotation and scale
    let texRot = 0.5f * a
    let texScale = 1.0f + math.sin(a) * 0.5f

    # compute an orbiting eye-position for testing sogl.lookat()
    let eyeX = math.sin(a) * 6.0f
    let eyeZ = math.cos(a) * 6.0f
    let eyeY = math.sin(a) * 3.0f

    sogl.defaults()
    sogl.loadPipeline(pip3d)

    sogl.enableTexture()
    sogl.texture(texView, smp)

    sogl.matrixModeProjection()
    sogl.perspective(sogl.asRadians(45.0f), 1.0f, 0.1f, 100.0f)
    sogl.matrixModeModelview()
    sogl.lookat(eyeX, eyeY, eyeZ, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f)
    sogl.matrixModeTexture()
    sogl.rotate(texRot, 0.0f, 0.0f, 1.0f)
    sogl.scale(texScale, texScale, 1.0f)
    cube()

proc frame() {.cdecl.} =
  let t = sapp.frameDuration().float32 * 60.0f

  # compute viewport rectangles so that the views are horizontally
  # centered and keep a 1:1 aspect ratio
  let dw = sapp.widthf()
  let dh = sapp.heightf()
  let ww = dh / 2.0f # not a bug
  let hh = dh / 2.0f
  let x0 = dw / 2.0f - hh
  let x1 = dw / 2.0f
  let y0 = 0.0f
  let y1 = dh / 2.0f

  # all sokol-gl functions except sogl.draw() can be called anywhere in the frame
  sogl.viewportf(x0, y0, ww, hh, true)
  drawTriangle()
  sogl.viewportf(x1, y0, ww, hh, true)
  drawQuad(t)
  sogl.viewportf(x0, y1, ww, hh, true)
  drawCubes(t)
  sogl.viewportf(x1, y1, ww, hh, true)
  drawTexCube(t)
  sogl.viewportf(0.0f, 0.0f, dw, dh, true)

  # Render the sokol-gfx default pass, all sokol-gl commands
  # that happened so far are rendered inside sogl.draw(), and this
  # is the only sokol-gl function that must be called inside
  # a sokol-gfx begin/end pass pair.
  # sogl.draw() also 'rewinds' sokol-gl for the next frame.
  sg.beginPass(sg.Pass(action: passAction, swapchain: sglue.swapchain()))
  sogl.draw()
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sogl.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  width: 512,
  height: 512,
  sampleCount: 4,
  windowTitle: "sgl.nim",
  icon: sapp.IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
