#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'
require 'test/unit'

class Person; end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    add_checked_attribute(Person, :age) {|v| v >= 18 }
    @bob = Person.new
  end
  def test_accepts_valid_values
    @bob.age = 20
    p @bob.method(:age).source_location
    # ["20120524/checked_attribute_3.rb", 30]
    assert_equal = 20, @bob.age
  end

  def test_refuses_invalid_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = 17
    end
  end

end

def add_checked_attribute(clazz, attribute, &validation)
  clazz.class_eval do
    define_method attribute do
      instance_variable_get("@attribute")
    end
    define_method "#{attribute}=" do |t|
      raise 'Invalid attribute' unless yield t
      instance_variable_set("@attribute", t)
    end
  end
end

