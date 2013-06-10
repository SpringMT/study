#!/usr/bin/env ruby
# encoding: UTF-8

require 'yaml'
require 'active_support/core_ext/hash'
#test = HashWithIndifferentAccess.new(YAML.load(DATA))


require 'pp'
require 'mysql2'
require 'thread'

class Bar
  def Bar.callback
    proc {
      puts "bar"
    }
  end
  def initialize
    ObjectSpace.define_finalizer(self, Bar.callback)
  end
end

while(1) do
  thread = []
  @t = 0
  10.times do |n|
    thread << Thread.new{
      @@a += 1 || 0
      @t += 1
      num = @t
      #print "#{num} start \n"
      #print "#{num} end \n"
      a = Bar.new
      p @@a
    }
  end
  thread.each {|t| t.join}
  #GC.start
  sleep 5
end


