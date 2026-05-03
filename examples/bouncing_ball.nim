#-------------------------------------------------------------------------------
# bouncing_ball.nim
# Authentic Amiga "Boing!" demo - red/white checkerboard sphere.
#-------------------------------------------------------------------------------
import sokol/log as slog
import sokol/gfx as sg
import sokol/app as sapp
import sokol/gl as sgl
import sokol/glue as sglue
import std/math

const passAction = PassAction(
  colors: [ColorAttachmentAction(loadAction: loadActionClear, clearValue: (0.1f, 0.1f, 0.2f, 1f))]
)

var
  ballX, ballY: float32
  ballVx, ballVy: float32
  ballRadius: float32 = 70f
  rotZ, rotX: float32 = 0f
  winW, winH: float32

proc init() {.cdecl.} =
  sg.setup(sg.Desc(environment: sglue.environment(), logger: sg.Logger(fn: slog.fn)))
  sgl.setup(sgl.Desc(logger: sgl.Logger(fn: slog.fn)))
  winW = sapp.widthf()
  winH = sapp.heightf()
  ballX = ballRadius + 20f
  ballY = winH - ballRadius - 20f
  ballVx = 300f
  ballVy = -600f

proc drawCheckerboardSphere(x, y, radius, rotZ, rotX: float32) =
  const bands = 12
  const segs = 12
  sgl.pushMatrix()
  sgl.translate(x, y, 0)
  sgl.rotate(sgl.asRadians(rotZ), 0, 0, 1)   # Horizontal rotation
  sgl.rotate(sgl.asRadians(rotX), 1, 0, 0)   # Y-axis spin (top/bottom)
  for lat in 0..<bands:
    let t1 = PI * (lat.float32 / bands.float32) - PI/2f
    let t2 = PI * ((lat + 1).float32 / bands.float32) - PI/2f
    for lon in 0..<segs:
      let p1 = 2f * PI * (lon.float32 / segs.float32)
      let p2 = 2f * PI * ((lon + 1).float32 / segs.float32)
      let isRed = ((lat + lon) mod 2) == 0
      let (r, g, b) = if isRed: (0.9f, 0.1f, 0.1f) else: (1f, 1f, 1f)
      sgl.c3f(r, g, b)
      sgl.beginQuads()
      sgl.v3f(radius * cos(t1) * cos(p1), radius * sin(t1), radius * cos(t1) * sin(p1))
      sgl.v3f(radius * cos(t1) * cos(p2), radius * sin(t1), radius * cos(t1) * sin(p2))
      sgl.v3f(radius * cos(t2) * cos(p2), radius * sin(t2), radius * cos(t2) * sin(p2))
      sgl.v3f(radius * cos(t2) * cos(p1), radius * sin(t2), radius * cos(t2) * sin(p1))
      sgl.end()
  sgl.popMatrix()

proc frame() {.cdecl.} =
  let dt = sapp.frameDuration()
  const gravity = 800f
  
  # Apply gravity
  ballVy += gravity * dt
  
  # Update position
  ballX += ballVx * dt
  ballY += ballVy * dt
  
  # Bounce off FLOOR (bottom) - fixed bounce height
  let floorY = winH - ballRadius
  if ballY > floorY:
    ballY = floorY
    ballVy = -600f  # Fixed upward velocity = constant bounce height
  
  # Bounce off ROOF (top)
  if ballY < ballRadius:
    ballY = ballRadius
    ballVy = 600f   # Fixed downward velocity
  
  # Bounce off walls - handle penetration
  if ballX < ballRadius:
    ballX = ballRadius
    ballVx = abs(ballVx)
  elif ballX > winW - ballRadius:
    ballX = winW - ballRadius
    ballVx = -abs(ballVx)
  
  # Update rotation based on movement
  rotZ += ballVx * dt * 0.3f    # Rotate with horizontal movement
  rotX += ballVy * dt * 0.2f    # Y-axis spin with vertical movement
  
  winW = sapp.widthf()
  winH = sapp.heightf()
  
  sg.beginPass(Pass(action: passAction, swapchain: sglue.swapchain()))
  sgl.defaults()
  sgl.matrixModeProjection()
  sgl.ortho(0, winW, winH, 0, -100, 100)
  sgl.matrixModeModelview()
  
  # Draw floor line (Amiga style)
  sgl.beginLines()
  sgl.c3f(0.3f, 0.3f, 0.5f)
  sgl.v2f(0, winH - 2f)
  sgl.v2f(winW, winH - 2f)
  sgl.end()
  
  drawCheckerboardSphere(ballX, ballY, ballRadius, rotZ, rotX)
  sgl.draw()
  sg.endPass()
  sg.commit()

proc cleanup() {.cdecl.} =
  sgl.shutdown()
  sg.shutdown()

sapp.run(sapp.Desc(
  initCb: init, frameCb: frame, cleanupCb: cleanup,
  width: 800, height: 600, windowTitle: "Amiga Boing! Ball",
  icon: IconDesc(sokol_default: true), logger: sapp.Logger(fn: slog.fn)
))
