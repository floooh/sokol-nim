#if defined(__APPLE__)
#include <OpenGL/gl3.h>
#else
#include <GL/gl.h>
#endif
#define SOKOL_IMPL
#define SOKOL_GLCORE33
#include "sokol/sokol_gfx.h"
