#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

sin = ->(x){ Math.sin(x) }
puts sin[Math::PI / 2]
