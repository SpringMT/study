#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

str1 = "string"
str2 = "string"
pp str1.object_id # 一意のobjectの番号
pp str2.object_id # 上記はことなる番号

pp str1 == str2 # true 内容は同じ
pp str1.equal?(str2) # false ないようは一緒だがオブジェクトとしては異なる

pp "string".class # String
pp 1.class # Fixnum
pp 1.class.class # Class


str = "lilliput"
pp str.length # 8
pp str << "ian"
pp str.length

#describe "p3 test" do
#  it "p3 simple test" do
#    str.length == 8
#  end
#end

