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
