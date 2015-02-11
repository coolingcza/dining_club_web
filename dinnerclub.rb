# Class: DinnerClub
#
# Models a dinner club that includes a number of diners.
#
# Attributes:
# @members     - Array: contains string values for each member's name.
# @member_list - Hash: contains running check totals for diners.
#
# Public Methods:
# #add_member
# #rem_member
# #event_go
# #check_members
# #upd_running_totals
# #upd_member_destinations

class DinnerClub
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :member_list, :id, :members, :table
  attr_accessor :name
    
  # Public: .find
  # Fetch a given record from the dinnerclub table.
  #
  # Parameters:
  # record_id - Integer: The dinner club's ID in the table.
  #
  # Returns: Array: Containing hopefully just one row (as a Hash).

#   def self.find(record_id)
#     table = "dinnerclub"
#     # results = DATABASE.execute("SELECT * FROM dinnerclub
# #                                 WHERE id = #{record_id}")
# #     record_details = results[0] # Hash of the record's details.
# #     record_details
#     #self.new(record_details)
#   end
  
  # Public: .where_name
  # Get a list of dinner clubs with the given name.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array: Containing matching dinner club records.
  
  def self.where_name(x)
    results = DATABASE.execute("SELECT * FROM dinnerclub WHERE name = '#{x}'")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
  end
  
  # Public: #initialize
  # Creates DinnerClub object and populates @member_list with initial values.
  #
  # Parameters:
  # members - Array: contains member names.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Creates @member_list hash from @members.
  
  def initialize(options)
    @name = options["name"]
    @id   = options["id"]
    @table = "dinnerclub"
  end
  
  
  # def insert
  #
  #   attributes = []
  #   instance_variables.each do |i|
  #     attributes << i.to_s.delete("@") if (i != :@id && i != :@table)
  #   end
  #
  #   values = []
  #   attributes.each do |a|
  #     value = self.send(a)
  #
  #     if value.is_a?(Integer)
  #       values << "#{value}"
  #     else values << "'#{value}'"
  #     end
  #   end
  #
  #   #binding.pry
  #
  #   DATABASE.execute("INSERT INTO #{@table} (#{attributes.join(", ")})
  #                     VALUES (#{values.join(", ")})")
  #   @id = DATABASE.last_insert_row_id
  #   binding.pry
  # end
  
  # Take all the attributes for this object and make sure
  # those are the values in this object's corresponding row
  # in the "students" table.
  #
  # def save
  #   attributes = []
  #
  #   # Example  [:@name, :@age, :@hometown]
  #   instance_variables.each do |i|
  #     # Example  :@name
  #     attributes << i.to_s.delete("@") # "name"
  #   end
  #
  #   query_components_array = []
  #
  #   attributes.each do |a|
  #     value = self.send(a)
  #
  #     if value.is_a?(Integer)
  #       query_components_array << "#{a} = #{value}"
  #     else
  #       query_components_array << "#{a} = '#{value}'"
  #     end
  #   end
  #
  #   query_string = query_components_array.join(", ")
  #   # name = 'Sumeet', age = 75, hometown = 'San Diego'
  #   binding.pry
  #   DATABASE.execute("UPDATE dinnerclub SET #{query_string} WHERE id = #{id}")
  # end
  
  # Public: #add_member
  # Adds member to @member_list.
  #
  # Parameters:
  # new_member - String: new member's name.
  #
  # Returns:
  # Updated @member_list.
  #
  # State Changes:
  # @member_list updated with new member key = new Person object.
  
  def add_member(new_member)
    @member_list[new_member] = Person.new(new_member, @id)
  end
  
  # Public: #rem_member
  # Removes member from @member_list.
  #
  # Parameters:
  # member - String: name of member to be removed.
  #
  # Returns:
  # Updated @member_list.
  #
  # State Changes:
  # Item in @member_list is removed.
  
  def remove_member(member)
    @member_list.delete(member)
  end
  
  # Public: #event_go
  # Generates CheckSplitter object, calls #check_members, #upd_running_totals,
  # #upd_member_destinations to update Person attributes for attendees.
  #
  # Parameters:
  # eventobj - Event: object generated by Event class.
  #
  # Returns:
  # Updated Person objects in @member_list.
  #
  # State Changes:
  # Person object attributes of attendees in @member_list.
  
  def event_go(eventobj)
    eventobj.record
    event_check = CheckSplitter.new(eventobj.bill, eventobj.attendees.length,  eventobj.id)
    
    event_check.record
    check_members(eventobj)
    #upd_running_totals(eventobj,event_check)
    #upd_member_destinations(eventobj)
    
    eventobj.attendees.each do |a|
      DATABASE.execute("INSERT INTO eventattend (event_id, person_id)
                        VALUES (#{eventobj.id}, #{@member_list[a].id})")
    end
    
    @member_list
  end
  
  # Public: #check_members
  # Adds new member if Event attendees list contains name not included in @member_list.
  #
  # Parameters:
  # eventobj - Event object: passed in from #event_go.
  #
  # Returns:
  # @member_list updated with new Person object.
  #
  # State Changes:
  # @member_list if new member.
  
  def check_members(eventobj)
    eventobj.attendees.each do |a| 
      unless @member_list.include?(a)
        add_member(a)
      end
    end
    @member_list
  end
  
  # Public: #upd_running_totals
  # Calls Person.spend to increase Person.spending_amt by tab at Dining Club Event.
  #
  # Parameters:
  # eventobj_name - Event object: passed in from #event_go.
  # event_check   - CheckSplitter object: generated in #event_go
  #
  # Returns:
  # Updated Person objects in @member_list.
  #
  # State Changes:
  # Person.spending_amt numbers of Event attendees.
  
  def upd_running_totals(eventobj_name, event_check)
    if eventobj_name.treat
      @member_list[eventobj_name.treater].spend(event_check.total_bill)
    else
      eventobj_name.attendees.each { |a| @member_list[a].spend(event_check.per_person) }
    end
  end
  
  # Public: #upd_member_destinations
  # Calls Person.places to record locations of events attended.
  #
  # Parameters:
  # eventobj - Event: a Dining Club Event object.
  #
  # Returns:
  # Updated member objects in @member_list.
  #
  # State Changes:
  # Member object destination arrays.
  
  def upd_member_destinations(eventobj)
    eventobj.attendees.each { |a| @member_list[a].places(eventobj.destination) }
  end
  
end
