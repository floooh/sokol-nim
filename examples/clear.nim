#-------------------------------------------------------------------------------
# clear.nim
# Clear the framebuffer.
#-------------------------------------------------------------------------------

import sokol/[app,appgfx,gfx]
import main

# statements at module scope are executed by sokol/app's init callback
app.setWindowTitle("clear")

# the main.cleanup callback will be invoked when the app window is closed
main.cleanup = proc() = gfx.shutdown()

# the main.event callback will be invoked for each user input event
main.event = proc(e:app.Event) = echo(e.type)

# the main.fail callback will be called in case of any app startup errors
main.fail = proc(s:string) = echo("err: " & s)

gfx.setup(gfx.Desc(context:context()))

var passAction = gfx.PassAction(
  colors:[
    gfx.ColorAttachmentAction(
      action:Action.Clear,
      value:(1,0,0,0),
    ),
  ]
)

main.frame = proc() =
  var g = passAction.colors[0].value.g + 0.01.float32
  passAction.colors[0].value.g = if g > 1f: 0f else: g
  gfx.beginDefaultPass(passAction, app.width(), app.height())
  gfx.endPass()
  gfx.commit()
# main.frame