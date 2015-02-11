require "sinatra"
require "sqlite3"
require "pry"

DATABASE = SQLite3::Database.new('dinnerclubweb.db')

require_relative "database_setup"
require_relative "database_methods"
require_relative "dinnerclub"
require_relative "person"

get "/" do
  erb :welcome, :layout => :boilerplate
end

get "/create_new_form" do
  #@source = request.path_info
  erb :create_new_form, :layout => :boilerplate
end

get "/new_club_info" do
  @source = request.referer

  @club = DinnerClub.new({"name" => params["clubname"]})
  @club.insert
  @members = params["members"].split", "
  @memberlist = []
  @members.each do |m|
    newperson = Person.new({"name"=>m,"club_id"=>@club.id})
    newperson.insert
    @memberlist << newperson
  end
  binding.pry

  erb :new_club_info, :layout => :boilerplate
  
end

get "/existing" do
  @source = request.path_info
  erb :existing_club, :layout => :boilerplate
  
end

get "/edit_options" do
  if params["clubname"]
    @club = DinnerClub.where_name(params["clubname"])
  else
    @club = DinnerClub.find("dinnerclub",params["id"])
  end
  erb :edit_options, :layout => :boilerplate
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