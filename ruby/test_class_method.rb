#!/usr/bin/env ruby
# encoding: UTF-8

class A
  def self.my_method
    self.test_hoge
  end
  def self.test_hoge
   p 1123
  end
end

A.my_method
