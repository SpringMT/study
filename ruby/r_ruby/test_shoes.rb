#!/usr/bin/env ruby

require 'shoes'

Shoes.app do
  button('Click me!') do
    alert 'Ruby rocks!'
  end
end


