#!/usr/bin/env ruby

require 'RMagick'
include Magick

img = Magick::Image.new(100,100){self.background_color = "red"}


img.write('a.png')



