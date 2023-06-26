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
  passAction = PassAction(
    colors: [ ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0f, 0f, 0f, 1f)) ]
  )
  numShapes = 5

var
  pip: sg.Pipeline
  vbuf: sg.Buffer
  ibuf: sg.Buffer
  vsParams: shd.VsParams
  shapes: array[numShapes, Shape] = [
    Shape(pos: vec3(-1f,  1f, 0f)),  # Box
    Shape(pos: vec3( 1f,  1f, 0f)),  # Plane
    Shape(pos: vec3(-2f, -1f, 0f)),  # Sphere
    Shape(pos: vec3( 2f, -1f, 0f)),  # Cylinder
    Shape(pos: vec3( 0f, -1f, 0f)),  # Torus
  ]
  rx, ry: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc(
    context: sglue.context(),
    logger: sg.Logger(fn: slog.fn),
  ))
  sdtx.setup(sdtx.Desc(
    fonts: [ sdtx.fontOric() ],
    logger: sdtx.Logger(fn: slog.fn),
  ))

  # shader and pipeline object for rendering the shapes
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(shapesShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      buffers: [ sshape.bufferLayoutDesc() ],
      attrs: [
        sshape.positionAttrDesc(),
        sshape.normalAttrDesc(),
        sshape.texcoordAttrDesc(),
        sshape.colorAttrDesc()
      ],
    ),
    indexType: indexTypeUint16,
    cullMode: cullModeNone,
    depth: DepthState(
      compare: compareFuncLessEqual,
      writeEnabled: true
    )
  ))

  # generate shape geometries
  var vertices: array[6 * 1024, sshape.Vertex]
  var indices: array[16 * 1024, uint16]
  var buf = sshape.Buffer(
    vertices: BufferItem(buffer: sshape.Range(addr: vertices.addr, size: vertices.sizeof)),
    indices: BufferItem(buffer: sshape.Range(addr: indices.addr, size: indices.sizeof))
  )
  buf = sshape.buildBox(buf, Box(width: 1f, height: 1f, depth: 1f, tiles: 10, randomColors: true))
  shapes[0].draw = sshape.elementRange(buf)
  buf = sshape.buildPlane(buf, Plane(width: 1f, depth: 1f, tiles: 10, randomColors: true))
  shapes[1].draw = sshape.elementRange(buf)
  buf = sshape.buildSphere(buf, Sphere(radius: 0.75f, slices: 36, stacks: 20, randomColors: true))
  shapes[2].draw = sshape.elementRange(buf)
  buf = sshape.buildCylinder(buf, Cylinder(radius: 0.5f, height: 1.5f, slices: 36, stacks: 10, randomColors: true))
  shapes[3].draw = sshape.elementRange(buf)
  buf = sshape.buildTorus(buf, Torus(radius: 0.5f, ringRadius: 0.3f, rings: 36, sides: 18, randomColors: true))
  shapes[4].draw = sshape.elementRange(buf)
  assert(buf.valid, "shape geometry buffer overflow")

  # one vertex/index buffer pair for all shapes
  vbuf = sg.makeBuffer(sshape.vertexBufferDesc(buf))
  ibuf = sg.makeBuffer(sshape.indexBufferDesc(buf))

proc frame() {.cdecl.} =
  # help text
  sdtx.canvas(sapp.widthf() * 0.5f, sapp.heightf() * 0.5f)
  sdtx.pos(0.5f, 0.5f)
  sdtx.puts("press key to switch draw mode\n\n")
  sdtx.puts("  1: vertex normals\n")
  sdtx.puts("  2: texture coords\n")
  sdtx.puts("  3: vertex colors")

  # view-projection matrix
  let proj = persp(60f, sapp.widthf() / sapp.heightf(), 0.01f, 10.0f)
  let view = lookat(vec3(0f, 1.5f, 6f), vec3.zero(), vec3.up())
  let viewProj = proj * view

  # rotation matrix
  let t: float32 = sapp.frameDuration() * 60f
  rx += 1f * t
  ry += 2f * t
  let rxm = rotate(rx, vec3(1f, 0f, 0f))
  let rym = rotate(ry, vec3(0f, 1f, 0f))
  let rm = rxm * rym

  # render shapes...
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(Bindings(vertexBuffers: [ vbuf ], indexBuffer: ibuf))
  for i in 0..<numShapes:
    # model matrix
    let model = translate(shapes[i].pos) * rm
    # model-view-proj matrix
    vsParams.mvp = viewProj * model
    sg.applyUniforms(shaderStageVs, shd.slotVsParams, sg.Range(addr: vsParams.addr, size: vsParams.sizeof))
    sg.draw(shapes[i].draw.baseElement, shapes[i].draw.numElements, 1)
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
  icon: IconDesc(sokol_default: true),
  logger: sapp.Logger(fn: slog.fn),
))
