#!/usr/bin/env ruby
# encoding: UTF-8

class A
  def my_method(hoge: 123)
    p hoge
  end
end

A.new.my_method hoge: 345


