# Main Class for DBSeeder
class dbseeder
  def self.create(adapter='', db_name='', db_user='', db_pass='', username='', password='')
    connection = Connection.new(adapter, db_name, db_user, db_pass)
    connection.setup
  end
end

require 'dbseeder/connection.rb'
