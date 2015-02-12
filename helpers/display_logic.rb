
module DisplayLogic

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

end