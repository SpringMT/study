#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

class Foo
  def my_method
    pp "duck typing"
  end
end

# hoge(引数)には何が来るかはbarでは定義しない
# hogeの振る舞いはhoge自身で決める
def bar(hoge)
  hoge.my_method
end

fuga = Foo.new
bar(fuga)

