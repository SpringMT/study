#!/usr/bin/env ruby
# encoding: UTF-8

total = 0
open("test_tcp_length") {|file|
  while num = file.gets
    total += num.to_i
  end
}

#printf("%.10f\n", ((total % 1024) %1024))

puts "Total #{total} b"


