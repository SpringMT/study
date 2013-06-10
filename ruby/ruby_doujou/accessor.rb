#!/usr/bin/ruby
# encoding: UTF-8

require 'pp'

$grobal = 'grobal'
CONST = 'const const'


class NonAccessorTest
    def initialize(args)
        puts 'NonAccessorTest initiallize'
        @nat_var = args
    end
end

class AccessorTest
    def initialize(args)
        @at_var = args
    end
    attr_accessor :at_var
    def access_at_var
        pp @at_var
    end
end

puts "*** accessor test ***"

nat = NonAccessorTest.new('nonaccessor1')
begin
    nat.nat_var
rescue => ex
    pp ex.class
    pp ex.message
    pp ex.backtrace
end

at = AccessorTest.new('accessor1')
puts at.at_var
at.at_var = 'accessor2'
pp at.at_var
at.access_at_var
