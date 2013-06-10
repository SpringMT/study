#!/usr/bin/ruby

require 'pp'
require 'getoptlong'
require 'rubygems'

args = GetoptLong.new
args.set_options(
    ['--file', '-f', GetoptLong::REQUIRED_ARGUMENT],
)
f = args.get

file_path = f[1].split(/\//)
file_name = file_path.pop
file_dir  = file_path.join('/')

$:.concat( ENV["GEM_PATH"].split(File::PATH_SEPARATOR).map{|path| path + "/gems" } )

tmp = Array.new()
$:.each do | path |
    path += "/#{file_dir}" if file_dir
    tmp.push path if FileTest.directory?(path)
end

#pp tmp

tmp.each do | path |
    dir = Dir.open path
    while file = dir.read
        if file =~ /^#{file_name}/ || file == "#{file_name}.rb" then
            puts "#{path}/#{file}"
        end
    end
end


#lpath = tmp.join(":")

#p $:


