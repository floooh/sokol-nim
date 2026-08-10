#-------------------------------------------------------------------------------
#   shapes.nim
#   Simple sokol_shapes.h demo.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/shape as sshape
import sokol/debugtext as sdtx
import sokol/glue as sglue
import math/vec3
import math/mat4
import shaders/shapes as shd

type Shape = object
  pos: Vec3
  draw: sshape.ElementRange

const
  numShapes = 5

var
  passAction: PassAction
  pip: sg.Pipeline
  vbuf: sg.Buffer
  ibuf: sg.Buffer
  vsParams: shd.VsParams
  shapeList: array[numShapes, Shape] = [
    Shape(pos: vec3(-1f,  1f, 0f)),  # Box
    Shape(pos: vec3( 1f,  1f, 0f)),  # Plane
    Shape(pos: vec3(-2f, -1f, 0f)),  # Sphere
    Shape(pos: vec3( 2f, -1f, 0f)),  # Cylinder
    Shape(pos: vec3( 0f, -1f, 0f)),  # Torus
  ]
  rx, ry: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    environment: sglue.environment(),
    logger: sg.Logger(fn: slog.fn),
  ))
  var desc = sdtx.Desc(
    logger: sdtx.Logger(fn: slog.fn),
  )
  desc.fonts[0] = sdtx.fontOric()
  sdtx.setup(desc)

  # Initialize passAction
  passAction.colors[0] = ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.0f, 0.0f, 0.0f, 1.0f))

  # generate shape geometries
  var vertices: array[sshape.maxVertexSize * 6 * 1024, uint8]
  var indices: array[16 * 1024, uint16]
  var shp = sshape.State(
    vertices: BufferState(buffer: sshape.Range(addr: vertices.addr, size: vertices.sizeof)),
    indices: BufferState(buffer: sshape.Range(addr: indices.addr, size: indices.sizeof))
  )
  sshape.buildBox(shp.addr, Box(width: 1f, height: 1f, depth: 1f, tiles: 10, randomColors: true))
  shapeList[0].draw = sshape.elementRange(shp)
  sshape.buildPlane(shp.addr, Plane(width: 1f, depth: 1f, tiles: 10, randomColors: true))
  shapeList[1].draw = sshape.elementRange(shp)
  sshape.buildSphere(shp.addr, Sphere(radius: 0.75f, slices: 36, stacks: 20, randomColors: true))
  shapeList[2].draw = sshape.elementRange(shp)
  sshape.buildCylinder(shp.addr, Cylinder(radius: 0.5f, height: 1.5f, slices: 36, stacks: 10, randomColors: true))
  shapeList[3].draw = sshape.elementRange(shp)
  sshape.buildTorus(shp.addr, Torus(radius: 0.5f, ringRadius: 0.3f, rings: 36, sides: 18, randomColors: true))
  shapeList[4].draw = sshape.elementRange(shp)
  # assert(shp.valid, "shape geometry buffer overflow")

  # one vertex/index buffer pair for all shapes
  vbuf = sg.makeBuffer(sshape.vertexBufferDesc(shp))
  ibuf = sg.makeBuffer(sshape.indexBufferDesc(shp))

  # shader and pipeline object for rendering the shapes
  pip = sg.makePipeline:
    var pd = PipelineDesc(
      shader: sg.makeShader(shapesShaderDesc(sg.queryBackend()))
    )
    pd.layout.buffers[0] = sshape.vertexBufferLayoutState(shp)
    pd.layout.attrs[0] = sshape.positionVertexAttrState(shp)
    pd.layout.attrs[1] = sshape.normalVertexAttrState(shp)
    pd.layout.attrs[2] = sshape.texcoordVertexAttrState(shp)
    pd.layout.attrs[3] = sshape.colorVertexAttrState(shp)
    pd.indexType = indexTypeUint16
    pd.cullMode = cullModeNone
    pd.depth = DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true
    )
    pd

proc frame() {.cdecl.} =
  # help text
  sdtx.canvas(sapp.widthf() * 0.5f, sapp.heightf() * 0.5f)
  sdtx.pos(0.5f, 0.5f)
  sdtx.puts("press key to switch draw mode\n\n")
  sdtx.puts("  1: vertex normals\n")
  sdtx.puts("  2: texture coords\n")
  sdtx.puts("  3: vertex colors")

  # view-projection matrix
  let proj = persp(60.0f, sapp.widthf() / sapp.heightf(), 0.01f, 10.0f)
  let view = lookat(vec3(0.0f, 1.5f, 6.0f), vec3.zero(), vec3.up())
  let viewProj = proj * view

  # rotation matrix
  let t: float32 = (sapp.frameDuration() * 60.0).float32
  rx += 1.0f * t
  ry += 2.0f * t
  let rxm = rotate(rx, vec3(1.0f, 0.0f, 0.0f))
  let rym = rotate(ry, vec3(0.0f, 1.0f, 0.0f))
  let rm = rxm * rym

  # render shapes...
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  sg.applyPipeline(pip)
  var bindings = Bindings()
  bindings.vertexBuffers[0] = vbuf
  bindings.indexBuffer = ibuf
  sg.applyBindings(bindings)
  for i in 0..<numShapes:
    # model matrix
    let model = translate(shapeList[i].pos) * rm
    # model-view-proj matrix
    vsParams.mvp = viewProj * model
    sg.applyUniforms(shd.ubVsParams.int32, sg.Range(addr: vsParams.addr, size: vsParams.sizeof))
    sg.draw(shapeList[i].draw.baseElement, shapeList[i].draw.numElements, 1)
  sdtx.draw()
  sg.endPass()
  sg.commit()

proc input(ev: ptr Event) {.cdecl.} =
  if ev.type == eventTypeKeyDown:
    vsParams.draw_mode = case ev.keyCode:
      of keyCode1: 0f
      of keyCode2: 1f
      of keyCode3: 2f
      else: vsParams.draw_mode

proc cleanup() {.cdecl.} =
  sdtx.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  eventCb: input,
  width: 800,
  height: 600,
  sampleCount: 4,
  windowTitle: "shapes.nim",
  icon: IconDesc(sokolDefault: true),
  logger: sapp.Logger(fn: slog.fn),
))
