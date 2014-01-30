require 'active_record'
require 'sqlite3'

ROOT ||= Dir.pwd
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3',
                                        :database => "#{ROOT}/db/database.sqlite3")

Dir.glob("#{ROOT}/app/uploaders/*.rb").each do |r| require r end
Dir.glob("#{ROOT}/app/models/*.rb").each do |r| require r end
Dir.glob("#{ROOT}/app/models/*/*.rb").each do |r| require r end
