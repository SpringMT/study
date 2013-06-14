#!/usr/bin/env ruby
# encoding: UTF-8

require 'active_support/concern'

module A
  extend ActiveSupport::Concern
  module ClassMethods
    def my_method
      p "my_method"
    end
  end
end

class B
  include A
end

B.my_method

