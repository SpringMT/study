require 'timeout'

Timeout.timeout(30, ArgumentError) {
   begin
     sleep 1
     p "sleep"
     raise "normal error"
   rescue => e
     raise e, "Timeout error"
   end
}

p "ここまでこない"
