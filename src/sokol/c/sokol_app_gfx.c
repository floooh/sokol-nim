#if defined(__ANDROID__)
    #define PLATFORM "Android "
#elif defined(__linux)
    #define PLATFORM "Linux "
#elif defined(__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__)
    #define PLATFORM "iOS "
#elif defined(__ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__)
    #define PLATFORM "macOS "
#elif defined(_WIN32) || defined(__CYGWIN__)
    #define PLATFORM "Windows "
    #define SOKOL_WIN32_FORCE_MAIN
#elif defined(__ORBIS__)
    #define PLATFORM "PlayStation "
#else
    #define PLATFORM ""
#endif

//------------------------------------------------------------------------------

#if defined(__aarch64__)
    #define CPU "ARM64 "
#elif \
    defined(ARM)     || \
    defined(_ARM)    || \
    defined(__arm)   || \
    defined(__arm__)
    #define CPU "ARM "
#elif \
    defined(_M_X64)     || \
    defined(_M_AMD64)   || \
    defined(__x86_64__)
    #define CPU "x86-64 "
#elif \
    defined(_M_IX86)  || \
    defined(__386__)  || \
    defined(__i386__) || \
    defined(__X86__)  || \
    defined(i386)
    #define CPU "x86 "
#else
    #define CPU ""
#endif

//------------------------------------------------------------------------------

#if defined(__clang__)
    #define COMPILER "clang v." __clang_version__
#elif defined(__GNUC__)
    #define COMPILER "gcc v." __VERSION__ " "
    // mingw64 gcc headers for D3D11 are missing this:
    #define D3D11_STANDARD_MULTISAMPLE_PATTERN (0xffffffff)
#elif defined(_MSC_VER)
    #define COMPILER COMPILER_(msc v._MSC_VER)
    #define COMPILER_(...) COMPILER__(__VA_ARGS__)
    #define COMPILER__(...) #__VA_ARGS__ " "
#else
    #define COMPILER ""
#endif

//------------------------------------------------------------------------------

#if defined(SOKOL_GLCORE33)
    #define GPUAPI "OpenGL 3.3 "
#elif defined(SOKOL_GLES2)
    #define GPUAPI "OpenGL ES 2 "
#elif defined(SOKOL_GLES3)
    #define GPUAPI "OpenGL ES 3 "
#elif defined(SOKOL_D3D11)
    #define GPUAPI "Direct3D 11 "
#elif defined(SOKOL_METAL)
    #define GPUAPI "Metal "
#elif defined(SOKOL_WGPU)
    #define GPUAPI "WebGPU "
#else
    #define GPUAPI ""
#endif

//------------------------------------------------------------------------------

#ifndef APPNAME
#define APPNAME PLATFORM CPU GPUAPI COMPILER
#endif

//------------------------------------------------------------------------------

#include "stdio.h"
#include "stdlib.h"
void sokol_assert_failed(const char* file, int line, const char* expr) {
    printf("%s:%i: SOKOL_ASSERT(%s) failed\n", file, line, expr);
    exit(1);
}

#define SOKOL_ASSERT(x) ((x)?(1):(sokol_assert_failed(__FILE__,__LINE__,#x),0))

//------------------------------------------------------------------------------

#include "sokol_app.h"
#include "sokol_gfx.h"
#include "sokol_glue.h"

//------------------------------------------------------------------------------

#if defined(SOKOL_IMPL)

    extern void app_onInit(void);
    extern void app_onCleanup(void);
    extern void app_onEvent(const sapp_event* event);
    extern void app_onFail(const char* msg);
    extern void app_onFrame(void);

    sapp_desc sokol_main(int argc, char* argv[]) {
        puts(APPNAME);
        sapp_desc desc = {
            .init_cb      = app_onInit,
            .cleanup_cb   = app_onCleanup,
            .frame_cb     = app_onFrame,
            .event_cb     = app_onEvent,
            .fail_cb      = app_onFail,
            .high_dpi     = true,
            .window_title = APPNAME,
        };
        return desc;
    }

#endif