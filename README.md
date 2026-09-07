[![build](https://github.com/floooh/sokol-nim/actions/workflows/main.yml/badge.svg)](https://github.com/floooh/sokol-nim/actions/workflows/main.yml)

Auto-generated Nim bindings for the [sokol headers](https://github.com/floooh/sokol).

> NOTE: if you are getting compilation errors about 'addr' please switch to the Nim development version (e.g. choosenim devel)

## Build and run samples

First install sokol as local module:

```sh
nimble install
```
Remember to do this each time you update the bindings.

Then to build and run the samples with the platform's default 3D backend
(D3D11 on Windows, Metal on macOS, GL on Linux):

```sh
nimble clear
nimble triangle
nimble quad
nimble bufferoffsets
nimble cube
nimble noninterleaved
nimble texcube
nimble shapes
nimble offscreen
nimble instancing
nimble mrt
nimble blend
nimble debugtext
nimble debugtextprintf
nimble debugtextuserfont
nimble sgl
nimble sglcontext
nimble sglpoints
nimble saudio
nimble instancingcompute
```

NOTE: on Windows, the MSVC C compiler will be used by all Nimble tasks. To build
with Clang or GCC on Windows, invoke the nim compiler directly with ```--cc```:

```sh
nim r --cc:clang examples/clear
nim r --cc:gcc examples/clear
```

To force the GL backend (on Windows or Mac) use ```-d:gl``` before the target:

```sh
nimble -d:gl clear
```

To build all samples into the ```build/``` subdirectory:

```sh
# with debug info
nimble build_debug
# in release mode:
nimble build_all
# ...or with forced GL backend:
nimble -d:gl build_debug
nimble -d:gl build_all
```

## Emscriptern - Web

To use `sokol-nim` with `emscripten` we need the [toolchain installed](https://github.com/emscripten-core/emsdk),
a [shell-file](https://github.com/emscripten-core/emscripten/blob/main/src/shell_minimal.html) and the following `config.nims` file:
(based on [this](https://github.com/treeform/nim_emscripten_tutorial?tab=readme-ov-file#step-1-using-nim-with-emscripten))

```nim
when defined(emscripten):
  # This path will only run if -d:emscripten is passed to nim.

  --nimcache:tmp # Store intermediate files close by in the tmp dir.

  --os:linux # Emscripten pretends to be linux.
  --cpu:wasm32 # Emscripten is 32bits.
  --cc:clang # Emscripten is very close to clang, so we will replace it.

  when defined(windows):
    --clang.exe:emcc.bat  # Replace C
    --clang.linkerexe:emcc.bat # Replace C linker
    --clang.cpp.exe:emcc.bat # Replace C++
    --clang.cpp.linkerexe:emcc.bat # Replace C++ linker.
  else:
    --clang.exe:emcc  # Replace C
    --clang.linkerexe:emcc # Replace C linker
    --clang.cpp.exe:emcc # Replace C++
    --clang.cpp.linkerexe:emcc # Replace C++ linker.
  --listCmd # List what commands we are running so that we can debug them.

  --exceptions:goto # Goto exceptions are friendlier with crazy platforms.
  --define:noSignalHandler # Emscripten doesn't support signal handlers.

  --threads:off

  # Pass this to Emscripten linker to generate html file scaffold for us.
  switch("passL", "-o build/index.html --shell-file template.html")

# next lines are optional to optimize build for speed
# when defined(release):
#  --opt:speed
```

If you're using `sokol` as dependency in your project you can just do `nimble build -d:release -d:emscripten` and serve
your template file using any HTTP server.

## Dear ImGui integration

> _The section below is LLM-generated._

sokol-nim ships bindings for `sokol_imgui.h`, `sokol_gfx_imgui.h` and
`sokol_app_imgui.h` as the Nim modules `sokol/imgui`, `sokol/gfximgui` and
`sokol/appimgui`. Because these headers depend on Dear ImGui (a C++ library),
sokol-nim does **not** compile the C stubs for you — the generator skips the
usual `{.compile: ...}` pragma for these three modules.

To use them, vendor [dcimgui](https://github.com/floooh/dcimgui) (an all-in-one
Dear ImGui + `cimgui.h` C-API drop) into your project and add compile pragmas
for the sokol stub and the dcimgui sources. Example for the regular flavour
(swap `src` for `src-docking` to get the docking flavour):

```nim
{.passC: "-I path/to/dcimgui/src -std=c11".}
{.passL: "-lc++".}   # or -lstdc++ on Linux
{.compile: "path/to/dcimgui/src/cimgui.cpp".}
{.compile: "path/to/dcimgui/src/cimgui_internal.cpp".}
{.compile: "path/to/dcimgui/src/imgui.cpp".}
{.compile: "path/to/dcimgui/src/imgui_draw.cpp".}
{.compile: "path/to/dcimgui/src/imgui_tables.cpp".}
{.compile: "path/to/dcimgui/src/imgui_widgets.cpp".}
{.compile: "path/to/dcimgui/src/imgui_demo.cpp".}
{.compile: "path/to/sokol-nim/src/sokol/c/sokol_imgui.c".}
```

(`import sokol/imgui` already applies `-DIMPL` globally via `{.passC.}`,
which is what turns on `SOKOL_IMGUI_IMPL` inside the stub. The
platform-specific backend define (`-DSOKOL_METAL`, `-DSOKOL_D3D11`, ...)
is applied globally by `import sokol/gfx`, so the imgui stub picks the
same renderer as sokol-gfx automatically. `sokol_gfx` / `sokol_app`
implementations are not re-emitted because the stub only pulls in their
headers as declarations.)

Then `import sokol/imgui` and use `simgui.setup(...)` as normal. Same shape
for `sokol_gfx_imgui.h` and `sokol_app_imgui.h`.
