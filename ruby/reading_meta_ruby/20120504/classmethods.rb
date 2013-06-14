#!/usr/bin/env ruby
# encoding: UTF-8

class A

  # selfはAクラス
  p self

  # インスタンスメソッドの追加
  def my_method
    p self
  end

  # 1. selfを使う
  def self.my_method1
    p "my_method1"
  end

  # 2. 特異クラスをオープンしてクラスメソッドを追加する
  class << self
    def my_method2
      p "my_method2"
    end
  end
end

A.my_method1
A.my_method2



