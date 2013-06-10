#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

name = gets
puts "Hello, #{name}"
printf "Hello %s", name
message = "Hello, %s" % name
puts message
$stderr.puts message
$stdout.puts message
p $stdout.class

