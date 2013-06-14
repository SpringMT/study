#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

pp "test test"
# 文字列であれば、同じ文字列でもオブジェクトは異なる(同一でない)
pp 'abc'.object_id
pp 'abc'.object_id


pp "test symbol"
test1 = "abc"
test2 = "abc"
# 別の変数なので別オブジェクトになる
pp test1.object_id
pp test2.object_id

# 同じ文字列なので、internで調べると一緒のsymbolを見る
pp test1.intern
pp test2.intern

# もちろんsymbolのobject_idは一緒
pp test1.intern.object_id
pp test2.intern.object_id
pp :abc.object_id

