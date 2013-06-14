#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

# このプログラムはPCをクラッシュさせる恐れがあるバグが含まれています。
exit

class A
  def method_missing(name, * args)
    3.times do
      number = rand(10) + 1
      puts number
    end
    "#{name} is #{number}"
  end
end

number =  A.new
puts number.bob



