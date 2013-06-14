#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

def my_method
  @shared = 0
end

def counter
  p @shared
end

def inc(args)
  @shared += args
end

my_method

counter
inc(4)
counter

