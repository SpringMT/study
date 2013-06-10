#!/usr/bin/ruby

require 'pp'
require 'oauth2'

client = OAuth2::Client.new(
  'makoto.haruyama@10xlab.jp',
  'vaxXzuce',
  :authorize_url => 'https://accounts.google.com/o/oauth2/auth')

authorize_url = client.auth_code.authorize_url



