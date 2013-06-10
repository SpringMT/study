#!/usr/bin/env ruby

require 'rubygems'
require 'pp'

version = ">= 0"

if ARGV.first =~ /^_(.*)_$/ and Gem::Version.correct? $1 then
      version = $1
        ARGV.shift
end

pp gem 'railties', version
pp Gem.bin_path('railties', 'rails', version)
