require 'benchmark_driver'
require "digest/sha2"

Benchmark.driver do |x|
  x.prelude <<~RUBY
    str             = 'abcdefg'
    valid_str       = 'abcdefg'
    all_invalid_str = 'hhhhhhh'
    one_invalid_str = 'ahhhhhh'
    two_invalid_str = 'abhhhhh'
  RUBY

  x.report 'valid_str',       %{ valid_str == str }
  x.report 'all_invalid_str', %{ all_invalid_str == str }
  x.report 'one_invalid_str', %{ one_invalid_str == str }
  x.report 'two_invalid_str', %{ two_invalid_str == str }

end
