import sokol/gfx

const quadVertices* = [
  # position             color0
  -1.0f, -1.0f, 0.0f,    1.0f, 0.0f, 0.0f, 0.5f,
  +1.0f, -1.0f, 0.0f,    0.0f, 1.0f, 0.0f, 0.5f,
  -1.0f, +1.0f, 0.0f,    0.0f, 0.0f, 1.0f, 0.5f,
  +1.0f, +1.0f, 0.0f,    1.0f, 1.0f, 0.0f, 0.5f
]

const bgVertexShader*: cstring =
  when gfx.gl:
    """
    #version 330
    layout(location=0) in vec2 position;
    void main() {
        gl_Position = vec4(position, 0.5, 1.0);
    }
    """
  elif gfx.metal:
    """
    #include <metal_stdlib>
    using namespace metal;
    struct vs_in {
      float2 position[[attribute(0)]];
    };
    struct vs_out {
      float4 pos [[position]];
    };
    vertex vs_out _main(vs_in in [[stage_in]]) {
      vs_out out;
      out.pos = float4(in.position, 0.5, 1.0);
      return out;
    }
    """
  elif gfx.d3d11:
    """
    struct vs_in {
      float2 pos: POS;
    };
    struct vs_out {
      float4 pos: SV_Position;
    };
    vs_out main(vs_in inp) {
      vs_out outp;
      outp.pos = float4(inp.pos, 0.5, 1.0);
      return outp;
    };
    """
  else:
    nil

const bgFragmentShader*: cstring =
  when gfx.gl:
    """
    #version 330
    uniform float tick;
    out vec4 frag_color;
    void main() {
        vec2 xy = fract((gl_FragCoord.xy-vec2(tick)) / 50.0);
        frag_color = vec4(vec3(xy.x*xy.y), 1.0);
    }
    """
  elif gfx.metal:
    """
    #include <metal_stdlib>
    using namespace metal;
    struct params_t {
      float tick;
    };
    fragment float4 _main(float4 frag_coord [[position]], constant params_t& params [[buffer(0)]]) {
      float2 xy = fract((frag_coord.xy-float2(params.tick)) / 50.0);
      return float4(float3(xy.x*xy.y), 1.0);
    }
    """
  elif gfx.d3d11:
    """
    cbuffer params: register(b0) {
      float tick;
    };
    float4 main(float4 frag_coord: SV_Position): SV_Target0 {
      float2 xy = frac((frag_coord.xy-float2(tick,tick)) / 50.0);
      float c = xy.x * xy.y;
      return float4(c, c, c, 1.0);
    };
    """
  else:
    nil

const quadVertexShader*: cstring =
  when gfx.gl: 
    """
    #version 330
    uniform mat4 mvp;
    layout(location=0) in vec4 position;
    layout(location=1) in vec4 color0;
    out vec4 color;
    void main() {
        gl_Position = mvp * position;
        color = color0;
    }
    """
  elif gfx.metal:
    """
    #include <metal_stdlib>
    using namespace metal;
    struct params_t {
      float4x4 mvp;
    };
    struct vs_in {
      float4 position [[attribute(0)]];
      float4 color [[attribute(1)]];
    };
    struct vs_out {
      float4 pos [[position]];
      float4 color;
    };
    vertex vs_out _main(vs_in in [[stage_in]], constant params_t& params [[buffer(0)]]) {
      vs_out out;
      out.pos = params.mvp * in.position;
      out.color = in.color;
      return out;
    }
    """
  elif gfx.d3d11:
    """
    cbuffer params: register(b0) {
      float4x4 mvp;
    };
    struct vs_in {
      float4 pos: POS;
      float4 color: COLOR;
    };
    struct vs_out {
      float4 color: COLOR;
      float4 pos: SV_Position;
    };
    vs_out main(vs_in inp) {
      vs_out outp;
      outp.pos = mul(mvp, inp.pos);
      outp.color = inp.color;
      return outp;
    }
    """
  else:
    nil

const quadFragmentShader*: cstring =
  when gfx.gl:
    """
    #version 330
    in vec4 color;
    out vec4 frag_color;
    void main() {
        frag_color = color;
    }
    """
  elif gfx.metal:
    """
    #include <metal_stdlib>
    using namespace metal;
    struct fs_in {
      float4 color;
    };
    fragment float4 _main(fs_in in [[stage_in]]) {
      return in.color;
    }
    """
  elif gfx.d3d11:
    """
    float4 main(float4 color: COLOR): SV_Target0 {
      return color;
    }
    """
  else:
    nil
