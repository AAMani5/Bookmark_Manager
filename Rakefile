require 'data_mapper'
require './app/bookmark_manager'


namespace :db do

  desc "Non destructive upgrade"
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts "Auto-upgrade complete (no data loss)"
  end


  desc "Destructive upgrade"
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts "Auto-migrate complete (data was lost)"
  end

end
## when auto_upgrade is run, first task will display the corresponding message on stdout
## when auto_migrate is run, second task will be executed and the corresponding msg will be displayed on stdout
