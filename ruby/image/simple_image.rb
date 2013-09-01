#!/usr/bin/env ruby
include Math
px = 240
py = 180
colmax  = 0xff
printf("P6\n%d %d\n%d\n",px,py,colmax)
cb = 0
cg = 0
cr = colmax
for i in 0 ... py
  for j in 0 ... px
    printf("%c%c%c",cr,cg,cb)
  end
end


