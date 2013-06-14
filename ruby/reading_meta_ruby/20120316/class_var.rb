#!/usr/bin/env ruby
# encoding: UTF-8
require 'pp'

class Foo
  @@foo = "aaa"
  def my_class_val
    pp @@foo
  end
end

class Bar < Foo
    @@foo = "bbb"
end

hoge = Foo.new
hoge.my_class_val

@@foo = "ccc"
pp @@foo


