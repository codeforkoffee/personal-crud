require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

set :database, { adapter: "sqlite3", database: "database.sqlite3" }

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  enable :sessions

  Dir.glob("models/*.rb").each { |r| require_relative r }
  Dir.glob("controllers/*.rb").each { |r| require_relative r }

  run! if app_file == $0
end
