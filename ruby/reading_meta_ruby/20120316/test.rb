#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

a = b = "abc"
b += "def"
p a == "abc"
p b == "abcdef"

a = "abc"
p a.object_id

a << "def"
# これだとオブジェクトは一緒
pp a
pp a.object_id

#これだとオブジェクトが変わる
a += "ghi"
pp a
pp a.object_id

#ダックタイピング
#シンタックスシュガー
pp "test symbl"
pp 'abc'.object_id
pp 'abc'.object_id

test1 = "abc"
test2 = "abc"
pp test1.intern
pp test2.intern

pp test1.object_id
pp test2.object_id

pp test1.intern.object_id
pp test2.intern.object_id
pp :abc.object_id


pp :lmn.object_id

#:test = "def"

pp "test big num"
test3 = 1
pp test3.object_id
test3 +=! 1
pp test3.object_id
test3 +=! 300
pp test3.object_id



#reverse

# クラス変数の挙動

class TestHoge
  @@foo = "aaa"
  def my_class_val
    pp @@foo
  end
end

class TestHuga < TestHoge
  @@foo = "bbb"
end


bar = TestHoge.new
bar.my_class_val

@@foo = "ccc"

pp @@foo

#bar2 = TestHuga.new
#bar2.my_class_val

#bar2 = TestHuga.new
#bar2.super.my_class_val


