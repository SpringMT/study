#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'
require 'test/unit'

class Person; end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    add_checked_attribute(Person, :age)
    @bob = Person.new
  end
  def test_accepts_valid_values
    @bob.age = 20
    assert_equal = 20, @bob.age
  end

  def test_refuses_nil_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = nil
    end
  end

  def test_refuses_false_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = false
    end
  end
end

def add_checked_attribute(clazz, attribute)

  #clazz.class_eval do
  #  def "#{attribute}"
  #    @"#{attribute}"
  #  end
  #  def "#{attribute}" = (value)
  #    raise RuntimeError, 'Invalid attribute' unless value
  #    @"#{attribute}" = value
  #  end
  #end

  clazz.class_eval do
    define_method attribute do
      instance_variable_get("@attribute")
      #@"#{attribute}"
    end
    define_method "#{attribute}=" do |t|
      instance_variable_set("@attribute", t)
    end
  end
  #clazz.instance_eval do |t|
  #    clazz.instance_variable_set(attribute.to_s, t)
  #  end
  #  clazz.instance_eval do
  #    clazz.instance_variable_get(attribute3.to_s)
  #  end
  #end

      #@#{attribute}
    #end
    #def #{attribute}=(value)
    #  raise RuntimeError, 'Invalid attribute' unless value
    #  @#{attribute} = value
    #end
  #end
end

