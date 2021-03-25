#include "sokol_defines.h"
#include "sokol_app.h"
#include "sokol_glue.h"

//------------------------------------------------------------------------------

#if defined(SOKOL_IMPL)

    extern void app_onInit(void);
    extern void app_onCleanup(void);
    extern void app_onEvent(const sapp_event* event);
    extern void app_onFail(const char* msg);
    extern void app_onFrame(void);

    sapp_desc sokol_main(int argc, char* argv[]) {
        sapp_desc desc = {
            .init_cb              = app_onInit,
            .cleanup_cb           = app_onCleanup,
            .frame_cb             = app_onFrame,
            .event_cb             = app_onEvent,
            .fail_cb              = app_onFail,
            .high_dpi             = true,
            .window_title         = "",
            .win32_console_utf8   = true,
            .win32_console_attach = true,
        };
        return desc;
    }

#endif