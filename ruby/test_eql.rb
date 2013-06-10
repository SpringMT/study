#!/usr/bin/env ruby
# encoding: UTF-8

class A
  def initialize
    @my_method = nil
  end
  def my_method=(arg)
    @my_method = arg
  end
  def my_method
    @my_method
  end

  def foo
    my_method = 123
    my_method
  end
  def bar
    self.my_method = 123
    my_method
  end
  def baz
    my_method
  end
end

p A.new.foo
p A.new.bar
p A.new.baz
