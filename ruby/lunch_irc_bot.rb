#!/usr/bin/env ruby
# encoding: UTF-8

# https://github.com/portertech/carrier-pigeon
require 'rubygems'
require 'carrier-pigeon'

CarrierPigeon.send(
  :uri => "irc://:6667/#cowork",
  :message => "ランチだよ",
  :ssl => false,
  :join => true
)


