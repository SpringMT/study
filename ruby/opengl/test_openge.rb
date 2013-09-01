require "opengl"
require "glut"

mouseX = 0
mouseY = 0

display = Proc.new{
  GL.Clear GL_COLOR_BUFFER_BIT

  # draw rect
  GL.Color3d 1.0, 1.0, 0.0
  GL.PushMatrix
  GL.Translatef mouseX, mouseY, 0
  GL.Begin GL_POLYGON
  GL.Vertex2d 0, 0
  GL.Vertex2d 0, 20
  GL.Vertex2d 20, 20
  GL.Vertex2d 20, 0
  GL.End
  GL.PopMatrix

  GL.Flush
  GLUT.SwapBuffers
}

resize = Proc.new{|w,h|
  GL.Viewport 0, 0, w, h
  GL.LoadIdentity
  GL.Ortho 0.0, w, h, 0.0, -1.0, 1.0
}

mouse_move = Proc.new{|x,y|
  mouseX = x
  mouseY = y
  GLUT.PostRedisplay
}

def init
  GL.ClearColor 0.0, 0.0, 0.0, 1.0
end

GLUT.Init
GLUT.InitDisplayMode GLUT_RGBA
GLUT.InitWindowSize 640, 480
GLUT.InitWindowPosition 0, 0
GLUT.CreateWindow "OpenGL:test"
GL.Clear GL_COLOR_BUFFER_BIT
GLUT.DisplayFunc display
GLUT.ReshapeFunc resize
GLUT.PassiveMotionFunc mouse_move
init
GLUT.MainLoop


