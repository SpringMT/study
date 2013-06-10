#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'
require 'active_support/deprecation'

class A
  def test
    p 123123
  end
  deprecate :test
end

obj = A.new
obj.test

