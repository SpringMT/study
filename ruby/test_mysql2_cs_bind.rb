#!/usr/bin/env ruby
# encoding: UTF-8

require 'pp'
require 'ap'
require 'active_record'
require 'active_record/base'
require 'active_record/connection_adapters/mysql2_adapter'
require 'mysql2-cs-bind'

class Test < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(
    :adapter   => 'mysql2',
    :encoding  => 'utf8',
    :reconnect => 'false',
    :username  => 'root',
    :password  => '',
    :database  => 'user',
    :socket    => '/tmp/mysql.sock',
  )
  self.table_name = 'user_data'
end

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      # Executes the SQL statement in the context of this connection.
      def xexecute(sql, value, name = nil)
        if name == :skip_logging
          @connection.xquery(sql, value)
        else
          log(sql, name) { @connection.xquery(sql, value) }
        end
      rescue ActiveRecord::StatementInvalid => exception
        if exception.message.split(":").first =~ /Packets out of order/
          raise ActiveRecord::StatementInvalid, "'Packets out of order' error was received from the database. Please update your mysql bindings (gem install mysql) and read http://dev.mysql.com/doc/mysql/en/password-hashing.html for more information. If you're on Windows, use the Instant Rails installer to get the updated mysql bindings."
        else
          raise
        end
      end
    end
  end
end


obj = Test.new
sql = 'SELECT * FROM user_data WHERE user_id = 2'
#xsql = 'SELECT * FROM user_data WHERE user_id = ?'
val = 2
@xres = obj.connection.xexecute(<<'SQL', val)
  SELECT
    mail_address
  FROM
    user_data
  WHERE
    user_id = ?
SQL

@xres.map { |f| ap f}

#@res = obj.connection.execute(sql)
#@res.map { |f| ap f}


