#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'

#http://d.hatena.ne.jp/rubikitch/20091229/ansicolor
# 色つけ
require 'term/ansicolor'
class String
    include Term::ANSIColor
end

unless open("| which bundle 2>/dev/null"){|f| f.gets}
  puts "please gem install bundle".red
  puts "gem install bundle".cyan
  abort
end

# check args num
unless ARGV.size == 1
  puts "please input just one word for new project".red
  abort
end

# current dir check
new_project_name = ARGV.first
dir = Dir.open(ENV['HOME'])
dir.each do |name|
  if name == new_project_name
    puts "ooops! same project already exist!\nrm -rf #{ENV['HOME']}/#{new_project_name}".red
    abort
  end
end
dir.close

puts "generate new project #{new_project_name}"

# make new project dir
new_dir = ENV['HOME'] + "/#{new_project_name}"
Dir.mkdir(new_dir)
Dir.chdir(new_dir)
puts "current dir is " + Dir.pwd

# make Gemfile
gemfile = "#{new_dir}/Gemfile"
File.open(gemfile, 'w') { |f|
  f.write <<EOF
source "http://rubygems.org"
gem "rails"
EOF
}

# exec
begin
  system "bundle install"
  puts 'bundle install ok'.cyan.bold

  system 'bundle exec rails new . -d mysql'
  puts 'bundle exec rails new . -d mysql ok'.cyan.bold

  system 'bundle install'
  puts 'bundle install ok'.cyan.bold
rescue => e
  puts $!.red.bold
  puts $@.red.bold
  abort
end


