def test(a, &blk)
  puts a
  blk.call
  "1111"
end

puts test("test").to_i


