require 'securerandom'

test = Hash.new {|h,k| h[k] = 0}
3000.times do
  uuid_end = SecureRandom.uuid[-1]
  test[uuid_end] += 1
end

p test.sort
