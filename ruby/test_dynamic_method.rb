#!/usr/bin/env ruby
# encoding: UTF-8

module A
  def foo
    "foo"
  end
end
user_data = {"hoge" => 123}
user_getter_class = Class.new do
  include A
  user_data.each do |key, value|
    define_method key.to_sym do
      value
    end
  end
end

p user_getter_class.new.hoge
p user_getter_class.new.foo

