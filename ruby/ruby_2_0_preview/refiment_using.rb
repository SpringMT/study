#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

module Foo
  refine String do
    def say
      puts "#{self}"
    end
  end
  #'hello'.say
end

#"hello".say

class Bar
  using Foo
  def my_method(args)
    ap String
    p args.method(:say).source_location
  end
end

Bar.new.my_method("aaaaa")

class Hoge
  include Foo
  def my_method(args)
    args.say
  end
end
# これは落ちる
#Hoge.new.my_method("aaaaa")


