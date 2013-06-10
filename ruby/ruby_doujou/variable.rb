#!/usr/bin/ruby
# encoding: UTF-8

require 'pp'

$grobal = 'grobal'
CONST = 'const const'

class VariableTestParent
    @instance_var = 'parent_i'
    @@class_var = 'parent_c'
    PARENT = 'VariableTestParent'
    puts "PARENT"
    p @instance_var
    p @@class_var

    def print_var_p
        pp @instance_var
        pp @@class_var
    end
end

class VariableTest < VariableTestParent
    puts "CHILD"
    @instance_var = 'child_i'
    p @instance_var
    p @@class_var

    def print_var
        #@instance_var = "hoegohegpojhe"
        pp @instance_var
        pp @@class_var
        #pp $grobal
        #pp VariableTestParent::PARENT
        #pp ::CONST
    end
end

puts "variable test\n"
puts "**** child new ****"
vt = VariableTest.new
vt.print_var

#puts "**** parent ****"
#vtp = VariableTestParent.new
#vtp.print_var_p
