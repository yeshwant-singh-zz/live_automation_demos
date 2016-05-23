# live_automation_demos

- create migration 
`bundle exec rake db:create_migration NAME=createuser`
- Update the file generated in db/migration/<timestamp>_createuser.rb
`
class CreateUser < ActiveRecord::Migration
  def change
   create_table :user_actions do |t|
     t.string :session_id, :index => true, :limit=>120
     t.string :webdriver_id, :index => true, :limit=>120
     t.boolean :click
     t.string :window_size
     t.string :scroll_by
   end
  end
end
`

run
`bundle exec rake db:migrate`

run app.rb and server is up and running
