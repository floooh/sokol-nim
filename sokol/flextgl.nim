{.deadCodeElim: on.}
{.compile: "native/flextGL.c".}
proc flextInit() {.importc:"flextInit",cdecl.}
proc init*() = flextInit()


