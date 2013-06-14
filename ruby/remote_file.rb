#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'

result = open("|ssh w001 ls")
print result.class

while !result.eof
  print result.gets
end

result.close

