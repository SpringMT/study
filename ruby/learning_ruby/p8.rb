#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'
require 'test/unit'

class Duration
  %w[ days hours minites seconds ].each do |name|
    attr_accessor name
  end
end

d = Duration.new
d.days = 3
d.hours = 5
pp d.days

