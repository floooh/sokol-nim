#pragma once
#include "stdio.h"
#include "stdlib.h"

//------------------------------------------------------------------------------

#if defined(_WIN32) && defined(__GNUC__)
    // mingw64 gcc headers for D3D11 are missing this:
    #define D3D11_STANDARD_MULTISAMPLE_PATTERN (0xffffffff)
#endif

//------------------------------------------------------------------------------

#define SOKOL_ASSERT(x) ((x)?(1):(sokol_assert_failed(__FILE__,__LINE__,#x),0))

static inline void
sokol_assert_failed(const char* file, int line, const char* expr) {
    printf("%s:%i: SOKOL_ASSERT(%s) failed\n", file, line, expr);
    exit(1);
}