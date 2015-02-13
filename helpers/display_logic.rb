# Module: DisplayLogic
#
# Assigns some route variables and executes database operations.
#
# Public Methods:
# #new_club_display
# #existing_club_display
# #edited_club_display
# #edit_actions
#
# module DisplayLogic

  # Public: new_club_display
   # Inserts new club and members into database, assigns
   # route variables for display.
   #
   # Parameters:
   # none.
   #
   # Returns: 
   # none.
   #
   # State changes:
   # Assigns @club, @memberlist, @vartext.

  # def new_club_display
    # @club = DinnerClub.new({"name" => params["clubname"]})
    # @club.insert
    # @members = params["members"].split", "
    # @memberlist = []
    # @members.each do |m|
    #   newperson = Person.new({"name"=>m,"club_id"=>@club.id})
    #   newperson.insert
    #   @memberlist << newperson
    # end
    # @vartext = "New Club Created:"
    #
  # end

  # Public: existing_club_display
   # Assigns route variables for display of existing club info.
   #
   # Parameters:
   # none.
   #
   # Returns: 
   # none.
   #
   # State changes:
   # Assigns @club, @memberlist, @vartext.

  # def existing_club_display
  #   @club = DinnerClub.find("dinnerclubs",params["clubid"])
  #   @memberlist = Person.where_club_id(@club.id)
  #   @vartext = "Existing Club"
  # end

  # Public: edited_club_display
   # Calls #edit_actions and assigns route variables for display of 
   # edited club info.
   #
   # Parameters:
   # none.
   #
   # Returns: 
   # none.
   #
   # State changes:
   # Assigns @club, @memberlist, @vartext.

  # def edited_club_display
    # @club = DinnerClub.find("dinnerclubs",params["clubid"])
    # if params["newclubname"]
    #   @club.name = params["newclubname"]
    #   @club.save
    # elsif params["oldmemname"]
    #   @member = Person.where_name(params["oldmemname"])[0]
    #   @member.name = params["newmemname"]
    #   @member.save
    # elsif params["addmemname"]
    #   @member = Person.new({"name"=>params["addmemname"],"club_id"=>@club.id})
    #   @member.insert
    # elsif params["remmemname"]
    #   @member = Person.where_name(params["remmemname"])
    #   @member[0].delete
    # end
    # @memberlist = Person.where_club_id(@club.id)
    # @vartext = "Modified Club Info"
  # end

  # Public: edit_actions
   # Alters @club or @member object and saves changes to database.
   #
   # Parameters:
   # none.
   #
   # Returns: 
   # none.
   #
   # State changes:
   # Modifies database.

  # def edit_actions
  #   if params["newclubname"]
  #     @club.name = params["newclubname"]
  #     @club.save
  #   elsif params["oldmemname"]
  #     @member = Person.where_name(params["oldmemname"])[0]
  #     @member.name = params["newmemname"]
  #     @member.save
  #   elsif params["addmemname"]
  #     @member = Person.new({"name"=>params["addmemname"],"club_id"=>@club.id})
  #     @member.insert
  #   elsif params["remmemname"]
  #     @member = Person.where_name(params["remmemname"])
  #     @member[0].delete
  #   end
  # end

# end