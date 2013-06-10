#!/usr/bin/env ruby
# 

class AliasTest
  def alias_test args
    p args
  end
  alias :=== :alias_test
  alias :=~ :alias_test
end

obj = AliasTest.new
obj.alias_test("hoge")
obj.===("hoge")

