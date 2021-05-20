#!/usr/bin/env ruby
# encoding: UTF-8

require 'mysql2'
require 'pry'

now = Time.now
client = Mysql2::Client.new(host: "172.23.60.96", username: "root", database: "test")

binding.pry

1000.times do
  client.query('select * from bench_test').each{}
end
p Time.now - now

