#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'
require 'awesome_print'
require 'ostruct'
require 'yaml'

conf = OpenStruct.new(:host => '0.0.0.0', :port => 3301)

conf.rc = File.join(Dir.pwd, 'conf.rc')

if File.exists?(conf.rc)
  YAML.load_file(conf.rc).each do |key, value|
    conf.send("#{key}=", value)
  end
end

#ap conf

conf.admin = 'haruyama'
p conf.admin

#ap conf

