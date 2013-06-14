#!/usr/bin/env ruby
# encoding: UTF-8

module D
  def my_method
    p "my_method"
  end
end

class E
  extend D
end

E.my_method

