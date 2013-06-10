#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

class A
  attr_accessor :foo
  def initialize
    @foo = 123
  end
end

obj = A.new
p obj.foo

