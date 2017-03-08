require 'data_mapper'
require 'dm-postgres-adapter'

require './app/models/link'
require './app/models/tag'
require './app/models/user'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!

# ENV['RACK_ENV'] by default is set to 'development' should be changed to 'test'
# in spec_helper.rb when running tests
