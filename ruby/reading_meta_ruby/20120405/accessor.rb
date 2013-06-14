#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

class A
  #attr_reader :mail_address_max_length
  #@mail_address_max_length = 256

  def initialize
    @mail_address_max_length = 256
  end
  def my_method
    p @mail_address_max_length
  end
end

foo = A.new
foo.my_method
