#!/usr/bin/env ruby
# coding: utf-8

require 'thor'

class ThorTest < Thor
  include Thor::Actions
  argument :name
  puts "#{name}"
end

ThorTest.start
