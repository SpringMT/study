#!/usr/bin/env ruby
# encoding: UTF-8
require 'pp'

pp "Ex) reverse"
foo = "abc"
pp foo.object_id

# non-destructive
foo.reverse
pp foo.object_id
pp foo

# destructive
foo.reverse!
pp foo.object_id
pp foo

pp "Ex) text concatination"
bar = "abc"
pp bar
pp bar.object_id

# non-destructive
bar += "def"
pp bar
pp bar.object_id

# destructive
bar << "ghi"
pp bar
pp bar.object_id


