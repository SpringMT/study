#!/usr/bin/env ruby
# encoding: UTF-8

Signal.trap(:EXIT) do
  dir_path = "/proc/#{$$}"
  p File.exist?(dir_path) ? `find #{dir_path} -type f|wc -l`.to_i : 0
end


p 123123




