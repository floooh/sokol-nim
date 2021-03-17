# just clears the framebuffer:
#
#   - basic initialization and draw loop
#   - clearing through a pass action

import sokol/app as app
import sokol/gfx as gfx

gfx.setup(gfx.Desc(
  context:app.gfxContext()
))

var passAction = gfx.PassAction(
  colors:[
    gfx.ColorAttachmentAction(
      action:Action.Clear,
      value:(1,0,0,0),
    ),
  ]
)

app.cleanup = proc() =
  gfx.shutdown()

app.event = proc(e:app.Event) =
  echo(e.type)

app.fail = proc(s:string) =
  echo("err: " & s)

app.frame = proc() =
  var g = passAction.colors[0].value.g + 0.01.float32
  passAction.colors[0].value.g = if g > 1.f: 0.f else: g
  gfx.beginDefaultPass(passAction, app.width(), app.height())
  gfx.endPass()
  gfx.commit()
