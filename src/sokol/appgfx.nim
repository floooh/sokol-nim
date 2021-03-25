# Sokol app/gfx glue -----------------------------------------------------------

import app
import gfx

proc context*():gfx.ContextDesc =
  result.colorFormat                  = cast[gfx.PixelFormat](app.colorFormat())
  result.depthFormat                  = cast[gfx.PixelFormat](app.depthFormat())
  result.sampleCount                  = app.sampleCount()
  result.gl.forceGles2                = app.gles2()
  result.metal.device                 = app.metalGetDevice()
  result.metal.renderpassDescriptorCb = app.metalGetRenderpassDescriptor
  result.metal.drawableCb             = app.metalGetDrawable
  result.d3d11.device                 = app.d3d11GetDevice()
  result.d3d11.deviceContext          = app.d3d11GetDeviceContext()
  result.d3d11.renderTargetViewCb     = app.d3d11GetRenderTargetView
  result.d3d11.depthStencilViewCb     = app.d3d11GetDepthStencilView
  result.wgpu.device                  = app.wgpuGetDevice()
  result.wgpu.renderViewCb            = app.wgpuGetRenderView
  result.wgpu.resolveViewCb           = app.wgpuGetResolveView
  result.wgpu.depthStencilViewCb      = app.wgpuGetDepthStencilView
