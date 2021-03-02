Auto-generated Nim bindings for the [sokol headers](https://github.com/floooh/sokol).

## Tested platform/compiler combinations

* Windows, Nim 1.4.2
  * cl 19.28.29336
  * clang 11.0.1
  * gcc 6.3.0 (Nim default on windows)

## Examples

Examples are found in `src/examples`, and can be compiled and run as follows:

```sh
# compile & run cube.nim using the platform's native graphics API
$ nim c --run --noMain src/examples/cube.nim

# compile & run cube.nim for OpenGL or OpenGL ES explicitly (-d:gl)
$ nim c --run --noMain -d:gl src/examples/cube.nim
```

You should pass the `--noMain` option to the Nim compiler, because the
`sokol/app` module provides a platform-specific application entry point,
and will call `NimMain` to execute module-level statements in your Nim modules.

## Limitations

Currently, it is assumed that `sokol/app` and `sokol/gfx` will be used together.
Removing this dependency is a future goal.