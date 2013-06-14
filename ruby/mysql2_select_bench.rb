#!/usr/bin/env ruby
# encoding: UTF-8

require 'mysql2'

now = Time.now
client = Mysql2::Client.new(host: "localhost", username: "root", database: "bench_work")
1000.times do
  client.query('select * from bench_test').each{}
end
p Time.now - now

