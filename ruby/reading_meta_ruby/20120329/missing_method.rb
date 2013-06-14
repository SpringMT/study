#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'
require 'awesome_print'

class A
  def method_missing(method_name, args, &block)
    if method_name =~ /^test/
      args.times { yield }
    else
      super
    end
  end
end

obj = A.new

obj.test_echo(5) {|x| puts "test" }
obj.echo(5) {|x| puts "test" }

