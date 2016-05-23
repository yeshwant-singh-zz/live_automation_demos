require 'sinatra'
require 'active_record'
require 'yaml'
require 'json'
#require 'octokit'
#require 'jenkins_api_client'
#require 'file-tail'
require 'fileutils'
#require 'mail'
#require 'redcarpet'

enable :sessions
@dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection @dbconfig['production']
#set :database, {adapter: "mysql2", database: "test", host: "localhost", username: "root", password: "yesh"}


class UserAction < ActiveRecord::Base
end

get '/session/:webdriver_id' do 
   webdriver_id = params[:webdriver_id]
   data = {:webdriver_id=> webdriver_id, :session_id => session.id}
   action = UserAction.find_by_session_id session.id
   if action.present?
     action[:webdriver_id] = data[:webdriver_id]
     action.save
   else
     UserAction.new(data).save
   end
end


get '/click' do
   data = {:session_id=> session.id, :click => true}
   action = UserAction.find_by_session_id session.id
   if action.present?
     action[:click] = data[:click]
     action.save
   else
     UserAction.new(data).save
   end
end

get '/window' do
   data = {:session_id=> session.id, :window_size => "some_size"}
   action = UserAction.find_by_session_id session.id
   if action.present?
     action[:window_size] = data[:window_size]
     action.save
   else
     UserAction.new(data).save
   end
end

get '/scroll' do
   data = {:session_id=> session.id, :scroll_by => "some_size"}
   action = UserAction.find_by_session_id session.id
   if action.present?
     action[:scroll_by] = data[:scroll_by]
     action.save
   else
     UserAction.new(data).save
   end
end

after do
  ActiveRecord::Base.clear_reloadable_connections!
end
