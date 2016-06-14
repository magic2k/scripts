require 'rubygems'
require 'mysql2'
require 'active_record'


ActiveRecord::Base.establish_connection(
  adapter:  'mysql',
  host:     'localhost',
  database: 'dbname',
  username: 'dbuser',
  password: 'dbpass'
)

class Generator < ActiveRecord::Base
  # table name that used in this class
  self.table_name = "profiles"
  def self.generate
    create(name: 'test_entry_from_blablabla', group_id: 170, profile_type: 'DEFAULT')
  end

  def self.delete
    Generator.where(profile_type: 'DEFAULT').last.destroy
    Generator.order("RAND()").limit(100).first.destroy
    Generator.where(profile_type: 'DEFAULT').first.destroy
    Generator.order("RAND()").limit(100).last.destroy
  end
end

ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0')

10000000.times do
  5.times do
    Generator.generate
  end
  Generator.delete
end

ActiveRecord::Base.connection.execute('SET foreign_key_checks = 1')
