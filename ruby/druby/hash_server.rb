# encoding: UTF-8
require 'drb/drb'
require 'ap'

front = Hash.new
DRb.start_service('druby://localhost:54300', front)
while true
  sleep 10
  ap front
end






