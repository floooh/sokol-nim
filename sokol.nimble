# Package
version       = "0.5.0"
author        = "Andre Weissflog, Garett Bass, Gustav Olsson"
description   = "Nim bindings for the sokol C headers"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["examples"]
binDir        = "examples/build"

# Dependencies
requires "nim >= 1.4.4"
import strformat

let examples = [
  "clear",
  "triangle",
  "quad",
  "bufferoffsets",
  "cube",
  "noninterleaved",
  "texcube",
  "shapes",
  "offscreen",
  "instancing",
  "mrt",
  "blend",
  "debugtext",
  "debugtextprintf",
  "debugtextuserfont",
  "sgl",
  "sglcontext",
  "sglpoints",
  "saudio"
]

let shaders = [
  "triangle",
  "quad",
  "bufferoffsets",
  "cube",
  "noninterleaved",
  "texcube",
  "shapes",
  "offscreen",
  "instancing",
  "mrt",
  "blend"
]

proc compilerSwitch(): string =
  when defined(windows):
    return "--cc:vcc"
  else:
    return ""

proc backendSwitch(): string =
  when defined gl:
    return "-d:gl"
  else:
    return ""

proc run(name: string) =
  exec &"nim r {compilerSwitch()} {backendSwitch()} examples/{name}"

# Tasks
task clear, "Runs the clear example":
  run "clear"

task triangle, "Runs the triangle example":
  run "triangle"

task quad, "Runs the quad example":
  run "quad"

task bufferoffsets, "Run the bufferoffsets example":
  run "bufferoffsets"

task cube, "Runs the cube example":
  run "cube"

task noninterleaved, "Runs the noninterleaved example":
  run "noninterleaved"

task texcube, "Runs the texcube example":
  run "texcube"

task shapes, "Runs the shapes example":
  run "shapes"

task offscreen, "Runs the offscreen example":
  run "offscreen"

task instancing, "Runs the instancing smaple":
  run "instancing"

task mrt, "Runs the mrt sample":
  run "mrt"

task blend, "Runs the blend example":
  run "blend"

task debugtext, "Runs the debugtext example":
  run "debugtext"

task debugtextprintf, "Runs the debugtextprintf example":
  run "debugtextprintf"

task debugtextuserfont, "Runs the debugtextuserfont example":
  run "debugtextuserfont"

task sgl, "Runs the sgl example":
  run "sgl"

task sglcontext, "Runs the sglcontext example":
  run "sglcontext"

task sglpoints, "Runs the sglpoints example":
  run "sglpoints"

task saudio, "Runs the saudio example":
  run "saudio"

task build_debug, "Build all examples in debug mode":
  # hmm, is there a better way?
  for example in examples:
      exec &"nim c --outdir:build {backendSwitch()} {compilerSwitch()} --debugger:native examples/{example}"

task build_all, "Build all examples in release mode":
  # hmm, is there a better way?
  for example in examples:
      exec &"nim c --outdir:build {backendSwitch()} {compilerSwitch()} -d:release examples/{example}"

task shaders, "Compile all shaders (requires ../sokol-tools-bin)":
  let binDir = "../sokol-tools-bin/bin/"
  let shdcPath =
    when defined(windows):
      &"{binDir}win32/sokol-shdc"
    elif defined(macosx) and defined(arm64):
      &"{binDir}osx_arm64/sokol-shdc"
    elif defined(macosx):
      &"{binDir}osx/sokol-shdc"
    else:
      &"{binDir}linux/sokol-shdc"
  for shader in shaders:
    let cmd = &"{shdcPath} -i examples/shaders/{shader}.glsl -o examples/shaders/{shader}.nim -l glsl330:metal_macos:hlsl4 -f sokol_nim"
    echo &"    {cmd}"
    exec cmd
