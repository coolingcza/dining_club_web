require "sinatra"
require "sqlite3"

DATABASE = SQLite3::Database.new('dinnerclubweb.db')

require_relative "database_setup"
require_relative "database_methods"
require_relative "dinnerclub"
require_relative "person"

get "/" do
  erb :welcome, :layout => :boilerplate
end

get "/create_new_form" do
  erb :create_new_form, :layout => :boilerplate
end

get "/club_info" do
  #if from 'create_new_form' -> sourcevar = "New"
  #x=request.path_info

  erb :club_info, :layout => :boilerplate
  
end

# get "/greet" do
#
#   params["user_name"]
#
#   person = params["user_name"]
#
#   "Hello, #{person}."
# end
#
#
# get "/user/:id" do
#   @user = User.find(params["id"])
#   erb :profile
# end
#
#
# get "/form" do
#   erb :index
# end
#
# after do
#   puts response.status
# end
#
# get "/result" do
#   logger.info
#   erb :result, :layout => :boilerplate
# end

# get "/second_page" do
#
# end