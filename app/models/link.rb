require 'data_mapper'
require 'dm-postgres-adapter'

class Link
  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :url,    String

end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!


# ENV['RACK_ENV'] by default is set to 'development' should be changed to 'test'
# in spec_helper.rb when running tests
