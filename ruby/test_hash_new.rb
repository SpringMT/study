#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

class A
  def self.my_method
    ap @hoge
  end
  def self.my_hash(key,value)
    @hoge ||={}
    @hoge[key] = value
  end
end

A.my_method
A.my_hash(1,2)
A.my_hash(3,4)
A.my_method

