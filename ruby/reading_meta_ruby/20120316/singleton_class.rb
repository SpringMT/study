#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

class Foo
  def my_method
    pp "original"
  end
end

bar = Foo.new

# 特異クラス追加
class << bar
  def add_class
    pp "add class"
  end
end
bar.add_class

# これはOK
bar_clone = bar.clone
bar_clone.add_class

#これはNG
bar_dup   = bar.dup
begin
  bar_dup.add_class
rescue => e
  pp e
end

hoge = Foo.new
# もちろん特異クラスはない
begin
  hoge.add_class
rescue => e
  pp e
end


