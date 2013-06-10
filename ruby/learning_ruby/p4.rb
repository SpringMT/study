#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

(2..100).each do |candidate|
  sqrt = Math.sqrt(candidate)
  # sqrtは小数点の数
  # anyで渡されるときには整数値のみ
  factor_found = (2..sqrt).any? {|i| candidate % i == 0}
  if factor_found then
    puts "#{candidate} is 合成数"
  else
    puts "#{candidate} is 素数"
  end
end

3.times do
  puts "Hello!"
end
