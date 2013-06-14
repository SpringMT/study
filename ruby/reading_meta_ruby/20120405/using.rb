#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

module Kernel
  def using(r)
    begin
      yield
    ensure
      r.dispose
    end
  end
end

