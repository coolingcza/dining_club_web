require "sinatra"
require "sqlite3"
require "pry"

DATABASE = SQLite3::Database.new('database/dinnerclubweb.db')

require_relative "database/database_setup"
require_relative "database/database_methods"
require_relative "models/dinnerclub"
require_relative "models/person"

#Routes

get "/" do
  erb :welcome, :layout => :boilerplate
end

get "/create_new_form" do
  #@source = request.path_info
  erb :create_new_form, :layout => :boilerplate
end

get "/display_club_info" do
  @source = request.referer
  if @source.include? "create_new_form"
    new_club_display
  elsif @source.include? "existing"
    existing_club_display
  else #@source includes edit_options
    edited_club_display
  end

  erb :display_club_info, :layout => :boilerplate
  
end

get "/existing" do
  @clublist = DinnerClub.all("dinnerclubs")
  erb :existing_club, :layout => :boilerplate
  
end

get "/edit_existing" do
  @clublist = DinnerClub.all("dinnerclubs")
  erb :edit_existing_club, :layout => :boilerplate
end

get "/edit_options" do
  @club = DinnerClub.where_name(params["clubname"])[0]
  @memberlist = Person.where_club_id(@club.id)
  erb :edit_options, :layout => :boilerplate
end



#Methods

def new_club_display
  @club = DinnerClub.new({"name" => params["clubname"]})
  @club.insert
  @members = params["members"].split", "
  @memberlist = []
  @members.each do |m|
    newperson = Person.new({"name"=>m,"club_id"=>@club.id})
    newperson.insert
    @memberlist << newperson
  end
  @vartext = "New Club Created:"
  
end

def existing_club_display
  @club = DinnerClub.find("dinnerclubs",params["clubid"])
  @memberlist = Person.where_club_id(@club.id)
  @vartext = "Existing Club"
end


def edited_club_display
  @club = DinnerClub.find("dinnerclubs",params["clubid"])
  edit_actions
  @memberlist = Person.where_club_id(@club.id)
  @vartext = "Modified Club Info"
end


def edit_actions
  if params["newclubname"]
    @club.name = params["newclubname"]
    @club.save
  elsif params["oldmemname"]
    @member = Person.where_name(params["oldmemname"])[0]
    @member.name = params["newmemname"]
    @member.save
  elsif params["addmemname"]
    @member = Person.new({"name"=>params["addmemname"],"club_id"=>@club.id})
    @member.insert
  elsif params["remmemname"]
    @member = Person.where_name(params["remmemname"])
    @member[0].delete
  end
end