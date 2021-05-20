require 'timeout'

file = File.open('test_hoge', 'a')
p file
logrh, logwh = IO.pipe
p [logrh, logwh]

if fork
  logwh.close
  Timeout.timeout(3) do
    logrh.each_line do |line|
      puts "parent #{line}"
      file.write line
    end
  end
  logrh.close
else
  logrh.close
  file.close
  $stderr.reopen(logwh)
  $stdout.reopen(logwh)
  logwh.close
  exec 'echo test && sleep 10'
end


