#-------------------------------------------------------------------------------
#   texcube.nim
#   Texture creation, rendering with texture, packed vertex components.
#-------------------------------------------------------------------------------
import sokol/gfx as sg
import sokol/app as sapp
import sokol/glue as glue
import math/vec3
import math/mat4
import shaders/texcube as shd

var
  rx, ry: float32
  pip: Pipeline
  bindings: Bindings

const
  passAction = PassAction(
    colors: [
      ColorAttachmentAction( action: Action.clear, value: (0.25, 0.5, 0.75, 1.0))
    ]
  )

type Vertex = object
  x, y, z: float32
  color: uint32
  u, v: uint16

proc init() {.cdecl.} =
  sg.setup(sg.Desc(context: glue.context()))

  #[
    Cube vertex buffer with packed vertex formats for color and texture coords.
    Note that a vertex format which must be portable across all
    backends must only use the normalized integer formats
    (BYTE4N, UBYTE4N, SHORT2N, SHORT4N), which can be converted
    to floating point formats in the vertex shader inputs.

    The reason is that D3D11 cannot convert from non-normalized
    formats to floating point inputs (only to integer inputs),
    and WebGL2 / GLES2 don't support integer vertex shader inputs.
  ]#
  bindings.vertexBuffers[0] = sg.makeBuffer(BufferDesc(
    data: [
      Vertex( x: -1.0, y: -1.0, z: -1.0,  color: 0xFF0000FF'u32, u:     0, v:     0 ),
      Vertex( x:  1.0, y: -1.0, z: -1.0,  color: 0xFF0000FF'u32, u: 32767, v:     0 ),
      Vertex( x:  1.0, y:  1.0, z: -1.0,  color: 0xFF0000FF'u32, u: 32767, v: 32767 ),
      Vertex( x: -1.0, y:  1.0, z: -1.0,  color: 0xFF0000FF'u32, u:     0, v: 32767 ),
      Vertex( x: -1.0, y: -1.0, z:  1.0,  color: 0xFF00FF00'u32, u:     0, v:     0 ),
      Vertex( x:  1.0, y: -1.0, z:  1.0,  color: 0xFF00FF00'u32, u: 32767, v:     0 ),
      Vertex( x:  1.0, y:  1.0, z:  1.0,  color: 0xFF00FF00'u32, u: 32767, v: 32767 ),
      Vertex( x: -1.0, y:  1.0, z:  1.0,  color: 0xFF00FF00'u32, u:     0, v: 32767 ),
      Vertex( x: -1.0, y: -1.0, z: -1.0,  color: 0xFFFF0000'u32, u:     0, v:     0 ),
      Vertex( x: -1.0, y:  1.0, z: -1.0,  color: 0xFFFF0000'u32, u: 32767, v:     0 ),
      Vertex( x: -1.0, y:  1.0, z:  1.0,  color: 0xFFFF0000'u32, u: 32767, v: 32767 ),
      Vertex( x: -1.0, y: -1.0, z:  1.0,  color: 0xFFFF0000'u32, u:     0, v: 32767 ),
      Vertex( x:  1.0, y: -1.0, z: -1.0,  color: 0xFFFF007F'u32, u:     0, v:     0 ),
      Vertex( x:  1.0, y:  1.0, z: -1.0,  color: 0xFFFF007F'u32, u: 32767, v:     0 ),
      Vertex( x:  1.0, y:  1.0, z:  1.0,  color: 0xFFFF007F'u32, u: 32767, v: 32767 ),
      Vertex( x:  1.0, y: -1.0, z:  1.0,  color: 0xFFFF007F'u32, u:     0, v: 32767 ),
      Vertex( x: -1.0, y: -1.0, z: -1.0,  color: 0xFFFF7F00'u32, u:     0, v:     0 ),
      Vertex( x: -1.0, y: -1.0, z:  1.0,  color: 0xFFFF7F00'u32, u: 32767, v:     0 ),
      Vertex( x:  1.0, y: -1.0, z:  1.0,  color: 0xFFFF7F00'u32, u: 32767, v: 32767 ),
      Vertex( x:  1.0, y: -1.0, z: -1.0,  color: 0xFFFF7F00'u32, u:     0, v: 32767 ),
      Vertex( x: -1.0, y:  1.0, z: -1.0,  color: 0xFF007FFF'u32, u:     0, v:     0 ),
      Vertex( x: -1.0, y:  1.0, z:  1.0,  color: 0xFF007FFF'u32, u: 32767, v:     0 ),
      Vertex( x:  1.0, y:  1.0, z:  1.0,  color: 0xFF007FFF'u32, u: 32767, v: 32767 ),
      Vertex( x:  1.0, y:  1.0, z: -1.0,  color: 0xFF007FFF'u32, u:     0, v: 32767 ),
    ]
  ))

  # create an index buffer for the cube
  bindings.indexBuffer = sg.makeBuffer(BufferDesc(
    type: BufferType.indexBuffer,
    data: [
      0'u16, 1, 2,  0, 2, 3,
      6, 5, 4,  7, 6, 4,
      8, 9, 10,  8, 10, 11,
      14, 13, 12,  15, 14, 12,
      16, 17, 18,  16, 18, 19,
      22, 21, 20,  23, 22, 20
    ]
  ))

  # create a checker board texture
  let pixels = sg.Range([
    0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32,
    0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32,
    0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32,
    0xFF000000'u32, 0xFFFFFFFF'u32, 0xFF000000'u32, 0xFFFFFFFF'u32,
  ])
  bindings.fsImages[shd.slotTex] = sg.makeImage(sg.ImageDesc(
    width: 4,
    height: 4,
    data: ImageData(
      subimage: [ [ pixels ] ]
    )
  ))

  # shader and pipeline object
  pip = sg.makePipeline(PipelineDesc(
    shader: sg.makeShader(texcubeShaderDesc(sg.queryBackend())),
    layout: LayoutDesc(
      attrs: [
        VertexAttrDesc(format: VertexFormat.float3),    # pos
        VertexAttrDesc(format: VertexFormat.ubyte4n),   # color0
        VertexAttrDesc(format: VertexFormat.short2n)    # texcoord0
      ]
    ),
    indexType: IndexType.uint16,
    cullMode: CullMode.back,
    depth: DepthState(
      compare: CompareFunc.lessEqual,
      writeEnabled: true
    )
  ))

proc computeVsParams(): shd.VsParams =
  let proj = persp(60.0f, sapp.widthf()/sapp.heightf(), 0.01f, 10.0f)
  let view = lookat(vec3(0.0f, 1.5f, 6.0f), vec3.zero(), vec3.up())
  let rxm = rotate(rx, vec3(1f, 0f, 0f))
  let rym = rotate(ry, vec3(0f, 1f, 0f))
  let model = rxm * rym
  result = VsParams(mvp: proj * view * model)

proc frame() {.cdecl.} =
  let dt = sapp.frameDuration() * 60f
  rx += 1f * dt
  ry += 2f * dt
  sg.beginDefaultPass(passAction, sapp.width(), sapp.height())
  sg.applyPipeline(pip)
  sg.applyBindings(bindings)
  sg.applyUniforms(ShaderStage.vs, shd.slotVsParams, computeVsParams())
  sg.draw(0, 36, 1)
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init,
  frameCb: frame,
  cleanupCb: cleanup,
  windowTitle: "texcube.nim",
  width: 800,
  height: 600,
  sampleCount: 4,
))
