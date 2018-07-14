#if defined(__APPLE__)
#include <OpenGL/gl3.h>
#elif defined(_WIN32)
#include "glad.h"
#else
#include <GL/gl.h>
#endif
#define SOKOL_IMPL
#define SOKOL_GLCORE33
#include "sokol/sokol_gfx.h"
