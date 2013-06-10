#!/usr/bin/env ruby

require 'pp'

class TapTest
    def my_method
        p "taptest"
    end
end

obj = TapTest.new
obj.tap {|a| a.my_method}

