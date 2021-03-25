#-------------------------------------------------------------------------------
# clear.nim
# Clear the framebuffer.
#-------------------------------------------------------------------------------

import sokol/[app,appgfx,gfx]


# statements at module scope are executed by sokol/app's init callback
app.setWindowTitle("clear")

# the app.cleanup callback will be invoked when the app window is closed
app.cleanup = proc() = gfx.shutdown()

# the app.event callback will be invoked for each user input event
app.event = proc(e:app.Event) = echo(e.type)

# the app.fail callback will be called in case of any app startup errors
app.fail = proc(s:string) = echo("err: " & s)

gfx.setup(gfx.Desc(context:context()))

var passAction = gfx.PassAction(
  colors:[
    gfx.ColorAttachmentAction(
      action:Action.Clear,
      value:(1,0,0,0),
    ),
  ]
)

app.frame = proc() =
  var g = passAction.colors[0].value.g + 0.01.float32
  passAction.colors[0].value.g = if g > 1f: 0f else: g
  gfx.beginDefaultPass(passAction, app.width(), app.height())
  gfx.endPass()
  gfx.commit()
