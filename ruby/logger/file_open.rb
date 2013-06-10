#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

Time.now
name = "#{Dir.pwd}/test_#{Time.now.to_i}.log"
#f = File.open(name, "a")
#f = File.open name, (File::WRONLY | File::APPEND)
f = File.open name, File::APPEND
f.write(1111111)
f.write(2222222)

