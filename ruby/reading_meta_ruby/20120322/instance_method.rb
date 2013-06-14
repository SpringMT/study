#!/usr/bin/env ruby
# encoding: UTF-8

#require 'pp'

class Foo
  def my_method
    p "my_method"
  end
end

bar  = Foo.new
hoge = Foo.new

# my_methodはbar(オブジェクト)のメソッド = Foo(クラス)のインスタンスメソッド
bar.my_method

p "methods"
p Foo.methods
p bar.methods

p "instance_methods"
p Foo.instance_methods
p bar.instance_methods
