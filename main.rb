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

get "/display_club_info" do
  @source = request.referer
  if @source.include? "create_new_form"
    new_club_display
  elsif @source.include? "existing"
    existing_club_display
  else #edit_options
    fetch_club_for_edit #returns club object

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
      binding.pry
      @member[0].delete
    end
    @memberlist = Person.where_club_id(@club.id)
    @vartext = "Modified Club Info"
  end

  erb :display_club_info, :layout => :boilerplate
  
end

get "/existing" do

  erb :existing_club, :layout => :boilerplate
  
end

get "/edit_existing" do
  erb :edit_existing_club, :layout => :boilerplate
end

get "/edit_options" do
  if params["clubname"]
    @club = DinnerClub.where_name(params["clubname"])[0]
  else
    @club = DinnerClub.find("dinnerclub",params["clubid"])
  end
  erb :edit_options, :layout => :boilerplate
end


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
  if params["clubname"]
    @club = DinnerClub.where_name(params["clubname"])[0]
  else
    @club = DinnerClub.find("dinnerclub",params["clubid"])
  end
  @memberlist = Person.where_club_id(@club.id)
  @vartext = "Existing Club"
end

def fetch_club_for_edit

  if @source.include? "clubid"
    @clubid = @source[-1..-1].to_i
    @club = DinnerClub.find("dinnerclub",@clubid)
  else
    eql = @source.index("=")
    @clubname = @source[eql+1..-1]
    @club = DinnerClub.where_name(@clubname)[0]
  end

end