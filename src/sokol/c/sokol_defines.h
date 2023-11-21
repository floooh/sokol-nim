#pragma once
#include <stdio.h>
#include <stdlib.h>

#ifndef NDEBUG
    #define SOKOL_ASSERT(x) ((x)?(1):(sokol_assert_failed(__FILE__,__LINE__,#x),0))
#endif

static inline void
sokol_assert_failed(const char* file, int line, const char* expr) {
    printf("%s:%i: SOKOL_ASSERT(%s) failed\n", file, line, expr);
    exit(1);
}
