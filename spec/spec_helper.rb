require 'pg'
require 'rspec'
require 'media'

DB = PG.connect(:dbname => 'library_test', :host => 'localhost')

RSpec.configure do |config|
  config.after(:each) do
    #puts ('Puts was here!')
    DB.exec("DELETE FROM media *;")
    DB.exec("DELETE FROM author *;")
    DB.exec("DELETE FROM title *;")
    DB.exec("DELETE FROM subject *;")
    DB.exec("DELETE FROM genre *;")
  end
end
