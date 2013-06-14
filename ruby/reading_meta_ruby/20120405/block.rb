#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

def my_method(a, b, &block1)
  p block1.class      # ブロックの所属クラス取得
  p block1.parameters # ブロックが持つ、引数が取れる
  p a + yield(a, b)
end

my_method(1, 2) {|x, y| x + y}

