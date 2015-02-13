require "sinatra"
require "sqlite3"
require "pry"

DATABASE = SQLite3::Database.new('database/dinnerclubweb.db')

require_relative "database/database_setup"
require_relative "database/database_methods"
require_relative "models/dinnerclub"
require_relative "models/person"
require_relative "helpers/display_logic"



helpers DisplayLogic



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
  @action = "/display_club_info"
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

get "/display_all" do
  if request.referrer.include? "delete"
    @club = DinnerClub.find("dinnerclubs",params["clubid"])
    @memberlist = Person.where_club_id(params["clubid"])
    @club.delete
    @memberlist.each{ |m| m.delete }
  end
  @clublist = DinnerClub.all("dinnerclubs")
  erb :display_all, :layout => :boilerplate
end

get "/delete_club" do
  @clublist = DinnerClub.all("dinnerclubs")
  @action = "/display_all"
  erb :existing_club, :layout => :boilerplate
end

get "/new_event" do
  @action = "/new_event_form"
  @clublist = DinnerClub.all("dinnerclubs")
  erb :existing_club, :layout => :boilerplate
end

get "/new_event_form" do
  @club = DinnerClub.find("dinnerclubs",params["clubid"])
  @memberlist = Person.where_club_id(@club.id)
  erb :new_event_form, :layout => :boilerplate
end

get "/event_confirm" do
  @club = DinnerClub.find("dinnerclubs",params["clubid"])
  @memberlist = Person.where_club_id(@club.id)
  #rework Event Class, clean out repeated & unnecessary methods
  #change checksplitter to module, include in Event--or just put methods in   
    #Event
  #call checksplitter methods on params to get total bill, per person
  #create entry in events table:
    #@event = Event.new(params[...])
  #create one entry in eventattend for each attendee:
    #see event_confirm for iteration
  #create attendance list by DATABASE/select on eventattend
  
  erb :event_confirm, :layout => :boilerplate
end

# clean up eventattend table when club member is removed? When club is deleted?