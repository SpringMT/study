# encoding: UTF-8
require 'drb/drb'

class Hello
  def hello
   puts 'Hello World!'
  end
end

DRb.start_service('druby://localhost:54000', Hello.new)

while true
  sleep 1
end




