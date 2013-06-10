#!/usr/bin/env ruby
# encoding: UTF-8

require 'active_support/core_ext'

class A
  def aaa
    puts "aaaaa"
  end
end

class B < A
  def aaa
    puts "bbbb"
  end

  alias_method_chain :aaa, :bbb
end


B.new.aaa


