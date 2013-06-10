#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

class A
  attr_accessor :hoge
  def my_method
    p hoge
  end

  def set_hoge
    @hoge = 123
  end

end

a = A.new
a.set_hoge
p a.hoge
a.my_method


