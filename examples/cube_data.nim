import sokol/gfx

const vertices*: array[168, float32] = [
  # position             color0
  -1.0f, -1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
   1.0f, -1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
  -1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.0f, 1.0f,

  -1.0f, -1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
   1.0f,  1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,
  -1.0f,  1.0f,  1.0f,   0.0f, 1.0f, 0.0f, 1.0f,

  -1.0f, -1.0f, -1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f,  1.0f, -1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f,  1.0f,  1.0f,   0.0f, 0.0f, 1.0f, 1.0f,
  -1.0f, -1.0f,  1.0f,   0.0f, 0.0f, 1.0f, 1.0f,

   1.0f, -1.0f, -1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f,  1.0f,  1.0f,   1.0f, 0.5f, 0.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   1.0f, 0.5f, 0.0f, 1.0f,

  -1.0f, -1.0f, -1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
  -1.0f, -1.0f,  1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
   1.0f, -1.0f,  1.0f,   0.0f, 0.5f, 1.0f, 1.0f,
   1.0f, -1.0f, -1.0f,   0.0f, 0.5f, 1.0f, 1.0f,

  -1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
  -1.0f,  1.0f,  1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
   1.0f,  1.0f,  1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
   1.0f,  1.0f, -1.0f,   1.0f, 0.0f, 0.5f, 1.0f,
]

const indices*: array[36, uint16] = [
   0u16, 1,  2,   0,  2,  3,
   6,    5,  4,   7,  6,  4,
   8,    9, 10,   8, 10, 11,
  14,   13, 12,  15, 14, 12,
  16,   17, 18,  16, 18, 19,
  22,   21, 20,  23, 22, 20,
]

const vertexShader*: cstring =
  when gfx.gl: # compiled for OpenGL or OpenGL ES
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
  elif gfx.d3d11: # compiled for Windows Direct3D 11
    """
    cbuffer Uniforms {
      float4x4 mvp;
    };

    struct vertex {
      float4 position :POSITION;
      float4 color0   :COLOR0;
    };

    struct fragment {
      float4 position :SV_Position;
      float4 color    :COLOR;
    };

    fragment main(vertex v) {
      fragment f;
      f.position = mul(mvp, v.position);
      f.color = v.color0;
      return f;
    }
    """
  elif gfx.metal: # compiled for macOS Metal
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
  else:
    nil

const fragmentShader*: cstring =
  when gfx.gl:
    """
    #version 330

    in vec4 color;

    out vec4 frag_color;

    void main() {
        frag_color = color;
    }
    """
  elif gfx.d3d11:
    """
    struct fragment {
      float4 position :SV_Position;
      float4 color    :COLOR;
    };

    float4 main(fragment f) :SV_Target {
      return f.color;
    }
    """
  elif gfx.metal:
    """
    #include <metal_stdlib>
    using namespace metal;
    fragment float4 _main(float4 color [[stage_in]]) {
      return color;
    }
    """
  else:
    nil
