#!/usr/bin/ruby


hash = Hash.new(0)
[1,1,1,1,1,3,4,5].each do | name |
    p name
    hash[name] = hash[name] + 1
    p hash
end

p hash

$:.unshift './'
require 'hoge'
