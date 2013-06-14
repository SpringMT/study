#!/usr/bin/env ruby
# encoding: UTF-8
require 'mysql2'

require 'pp'

now = Time.now
client = Mysql2::Client.new(host: "localhost", username: "root", database: "bench_work")
client.query(<<EOF)
create table test (
  tiny tinyint,
  utiny tinyint unsigned,
  small smallint,
  usmall smallint unsigned,
  medium mediumint,
  umedium mediumint unsigned,
  i int,
  ui int unsigned,
  big bigint,
  ubig bigint unsigned,
  f float,
  d double,
  c char(100),
  vc varchar(100),
  date date,
  datetime datetime,
  timestamp timestamp
) charset utf8 engine innodb
EOF

t = Time.now.strftime('%Y%m%d%H%M%S')
10000.times do
  client.query("insert into test values (123,123,123456,123456,1234567,1234567,123456789,123456789,12345678900,12345678900,123.456,123.456,'abcdefghijklmnopqrstuvwxyz','abcdefghijklmnopqrstuvwxyz','#{t}','#{t}','#{t}')")
end
p Time.now - now

