#!/usr/bin/env ruby
# encoding: UTF-8

require 'handler_socket'
require 'ap'

ap @hs = HandlerSocket.new(:host => '192.168.110.25', :port => '9998')
#ap @hs.error_code
ap @hs.open_index(1, 'hs_test', 'test', 'PRIMARY', 'data')
#ap @hs.error_code
ap @hs.execute_single(1, '=', [1], 1,0)

@hs.close


