# Package
version       = "0.5.0"
author        = "Andre Weissflog, Garett Bass, Gustav Olsson"
description   = "Nim bindings for the sokol C headers"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["examples"]

# Dependencies
requires "nim >= 1.4.4"

# Tasks
task clear, "Runs the clear example":
  exec "nim r examples/clear"

task cube, "Runs the cube example":
  exec "nim r examples/cube"

task blend, "Runs the blend example":
  exec "nim r examples/blend"

task build_all, "Build all examples":
  # hmm, is there a better way?
  let examples = [ "clear", "cube", "blend" ]
  for example in examples:
    when defined windows:
      exec "nim c --cc:vcc examples/" & example
    else:
      exec "nim c examples/" & example