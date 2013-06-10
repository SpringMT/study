#!/usr/bin/env ruby
# encoding: UTF-8

require 'ap'
require 'active_support/tagged_logging'
require 'active_support/buffered_logger'

path = '/Users/makotoharuyama/ruby_study/logger/test.log'

f = File.open path, 'a'

# http://ameblo.jp/nana-2007-july/entry-10099593812.html
f.binmode
# バッファリング切ってる
f.sync = true

logger = ActiveSupport::TaggedLogging.new(
  ActiveSupport::BufferedLogger.new(f)
)
#logger.level = Logger::ERROR

#logger.tagged("haruyama") { logger.info "Stuff" }
#logger.silence { logger.info "hoge" }
#logger.debug "debug test"
#logger.info "info test"
#logger.warn "warn test"
#logger.fatal "fatal test"
#logger.unknown "unknown test"

#logger.info "ああああ"

def my_methods
  p caller.first
end

my_methods

