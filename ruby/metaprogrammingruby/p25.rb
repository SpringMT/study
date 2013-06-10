#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

class Entity
  attr_reader :table, :ident

  def initialize(table, ident)
    @table = 
