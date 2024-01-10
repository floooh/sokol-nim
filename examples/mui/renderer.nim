include atlas

import sokol/log as slog
import sokol/app as sapp
import sokol/gfx as sg
import sokol/glue as sglue
import sokol/gl as sgl

var
  atlas_img: sg.Image
  atlas_smp: sg.Sampler
  pip: sgl.Pipeline

proc r_init =
  const rgba8_size = ATLAS_WIDTH * ATLAS_HEIGHT * 4
  var rgba8_pixels: array[rgba8_size, uint32]
  for y in 0..<ATLAS_HEIGHT:
    for x in 0..<ATLAS_WIDTH:
      let idx = y * ATLAS_WIDTH + x
      rgba8_pixels[idx] = 0x00FFFFFF or ((atlas_texture[idx].uint32) shl 24)
  var st: sg.ImageDesc
  st.width = ATLAS_WIDTH
  st.height = ATLAS_HEIGHT
  st.data.subimage[0][0] = sg.Range(addr: rgba8_pixels[0].addr, size: rgba8_size)
  atlas_img = makeImage(st)
  var sa: sg.SamplerDesc
  sa.minFilter = sg.filterNearest
  sa.magFilter = sg.filterNearest
  atlas_smp = makeSampler(sa)
  var sp: sg.PipelineDesc
  sp.colors[0].blend = sg.BlendState(enabled: true, srcFactorRgb: blendFactorSrcAlpha, dstFactorRgb: blendFactorOneMinusSrcAlpha)
  pip = sgl.makePipeline(sp)

proc r_begin(dw, dh: int) =
  sgl.defaults()
  sgl.pushPipeline()
  sgl.loadPipeline(pip)
  sgl.enableTexture()
  sgl.texture(atlas_img, atlas_smp)
  sgl.matrixModeProjection()
  sgl.pushMatrix()
  sgl.ortho(0.0f, dw.float, dh.float, 0.0f, -1.0f, 1.0f)
  sgl.beginQuads()

proc r_end =
  sgl.end()
  sgl.popMatrix()
  sgl.popPipeline()

proc r_draw =
  sgl.draw()

proc r_push_quad(dst, src: mu.Rect, color: mu.Color) =
  let
    u0 = src.x.float / ATLAS_WIDTH.float
    v0 = src.y.float / ATLAS_HEIGHT.float
    u1 = (src.x + src.w).float / ATLAS_WIDTH.float
    v1 = (src.y + src.h).float / ATLAS_HEIGHT.float
    x0 = dst.x.float
    y0 = dst.y.float
    x1 = (dst.x + dst.w).float
    y1 = (dst.y + dst.h).float

  sgl.c4b(color.r, color.g, color.b, color.a)
  sgl.v2fT2f(x0, y0, u0, v0)
  sgl.v2fT2f(x1, y0, u1, v0)
  sgl.v2fT2f(x1, y1, u1, v1)
  sgl.v2fT2f(x0, y1, u0, v1)

proc r_draw_rect(rect: mu.Rect, color: mu.Color) =
  r_push_quad(rect, atlas[ATLAS_WHITE], color)

proc r_draw_text(text: cstring, pos: mu.Vec2, color: mu.Color) =
  var dst = mu.rect(pos.x, pos.y, 0, 0)
  for i in 0..<text.len:
    var src = atlas[ATLAS_FONT + text[i]]
    dst.w = src.w
    dst.h = src.h
    r_push_quad(dst, src, color)
    dst.x += dst.w

proc r_draw_icon(id: int, rect: mu.Rect, color: mu.Color) =
  var
    src = atlas[id]
    x = rect.x + (rect.w - src.w) div 2
    y = rect.y + (rect.h - src.h) div 2
  r_push_quad(mu.rect(x, y, src.w, src.h), src, color)

proc r_get_text_width(text: cstring, len: cint): cint =
  for i in 0..<len:
    result += atlas[ATLAS_FONT + text[i]].w

proc r_get_text_height: cint = 18

proc r_set_clip_rect(rect: mu.Rect) =
  sgl.end()
  sgl.scissorRect(rect.x, rect.y, rect.w, rect.h, true)
  sgl.beginQuads()

