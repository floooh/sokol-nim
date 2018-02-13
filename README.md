# sokol-nim
nim bindings for https://github.com/floooh/sokol

WORK IN PROGRESS!

Example code is here: https://github.com/floooh/sokol-nim-samples

## Current Limitations

- only tested on MacOS
- hardwired to the sokol-gfx GL backend
- I'm still a Nim noob, some things may not be proper Nim-style

## How to use

### Refer to the sokol C headers for documentation:

https://github.com/floooh/sokol

### Check the sokol-nim samples:

https://github.com/floooh/sokol-nim-samples

### Nim specifics:

A custom operator **%[]** has been added to initialize
fixed size arrays from variable-sized open arrays (I'm still a
Nim noob, may be there's a better way).

Some structure names have been shortened to make object initialization
a bit more convenient (e.g. C's _shader_uniform_block_desc_ has
become _uniform_block_desc_).

## A Triangle in Nim with GLFW:

```nim
import glfw3 as glfw
import sokol/gfx as sg

# initialize GLFW, FlextGL and sokol
if glfw.Init() != 1:
    quit(QUIT_FAILURE)
glfw.WindowHint(CONTEXT_VERSION_MAJOR, 3)
glfw.WindowHint(CONTEXT_VERSION_MINOR, 3)
glfw.WindowHint(OPENGL_PROFILE, OPENGL_CORE_PROFILE)
glfw.WindowHint(OPENGL_FORWARD_COMPAT, 1)
let win = glfw.CreateWindow(640, 480, "Triangle (sokol-nim)", nil, nil)
glfw.MakeContextCurrent(win)
sg.setup(sg.desc())

# a vertex buffer
var vertices = [
    # positions            colors
    0.0f,  0.5f, 0.5f,     1.0f, 0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,     0.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,    0.0f, 0.0f, 1.0f, 1.0f     
]
let vbuf = sg.make_buffer(sg.buffer_desc(
    size: sizeof(vertices).cint,
    content: addr(vertices)
))

# a shader
let shd = sg.make_shader(sg.shader_desc(
    vs: stage_desc(
        source: """
            #version 330
            in vec4 position;
            in vec4 color0;
            out vec4 color;
            void main() {
                gl_Position = position;
                color = color0;
            }
        """),
    fs: stage_desc(
        source: """
            #version 330
            in vec4 color;
            out vec4 frag_color;
            void main() {
                frag_color = color;
            }
        """)
))

# a pipeline state object
let pip = sg.make_pipeline(sg.pipeline_desc(
    shader: shd,
    layout: layout_desc(
        attrs: %[
            attr_desc(name: "position", format: VERTEXFORMAT_FLOAT3),
            attr_desc(name: "color0", format: VERTEXFORMAT_FLOAT4)
        ]
    )
))

# a draw state with the resource bindings
let draw_state = sg.draw_state(
    pipeline: pip,
    vertex_buffers: %[vbuf]
)

# a default pass action (clears to grey)
let pass_action = sg.pass_action()

# draw loop
while glfw.WindowShouldClose(win) == 0:
    var w, h: int32
    glfw.GetFramebufferSize(win, addr(w), addr(h))
    sg.begin_default_pass(pass_action, w, h)
    sg.apply_draw_state(draw_state)
    sg.draw(0, 3, 1)
    sg.end_pass()
    sg.commit()
    glfw.SwapBuffers(win)
    glfw.PollEvents()

# cleanup
sg.shutdown()
glfw.Terminate()
```