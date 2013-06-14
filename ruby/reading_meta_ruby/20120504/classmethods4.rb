#!/usr/bin/env ruby
# encoding: UTF-8

module A
  def self.included(klass)
    klass.extend ClassMethods
  end

  def my_method_i
    p "my_method_i"
  end

  module ClassMethods
    def my_method_c
      p "my_method_c"
    end
  end

  # モジュールAに特異メソッドを追加する
  extend ClassMethods
end

A.my_method_c

class C
  include A
end

# クラスメソッドとして追加されている
C.my_method_c

# インスタンスメソッドとして追加されている
obj = C.new
obj.my_method_i



