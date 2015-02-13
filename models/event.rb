# Class: Event
#
# Models an event attended by a Dinner Club.
#
# Attributes:
# @attendees    - Array: Members of dinner club attending event.
# @destination  - String: restaurant name where event is hosted.
# @bill         - Float: Bill for event for entire group.
# @treat        - Boolean: True if one member of the dinner club pays entire bill.
# @treater      - String: acquired if @treat, name of member who pays entire bill.
#
# Public Methods:
# none

class Event
  attr_accessor :attendees, :destination, :bill, :treat, :treater, :id, :club_id
  
  # Public: .where_restaurant
  # Get a list of events at the given restaurant.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array: Containing matching Student objects.
  
  def self.where_restaurant(x)
    results = DATABASE.execute("SELECT * FROM event WHERE restaurant = '#{x}'")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
    
    results
  end
  
  # Public: .find
  # Fetch a given record from the event table.
  #
  # Parameters:
  # record_id - Integer: The event's ID in the table.
  #
  # Returns: Array: Containing hopefully just one row (as a Hash).
  
  def self.find(record_id)
    results = DATABASE.execute("SELECT * FROM event WHERE id = #{record_id}")
    record_details = results[0] # Hash of the record's details.
    record_details
    #self.new(record_details)
  end
  
  # Public: #initialize
  # Creates Event object and acquires @treater if @treat is true.
  #
  # Parameters:
  # attendees   - Array: contains names of Dinner Club members who attend event.
  # destination - String: name of restaurant at which event is held.
  # bill        - Float: bill for entire party.
  # treat       - Boolean: default false, true if one member is paying for entire party.
  #
  # Returns:
  
  # None.
  #
  # State Changes:
  # Creates and fills @treater if @treat is true.
  
  def initialize(options)
    #@attendees   = options["attendees"]
    @destination = options["restaurant"]
    @bill        = options["bill"]
    @club_id     = options["club_id"]
    @treater     = options["treater"]
    @table       = "events" 

    #record
  end
  
  def insert
    DATABASE.execute("INSERT INTO event (restaurant, club_id) 
                      VALUES ('#{destination}', #{club_id})")
    @id = DATABASE.last_insert_row_id
  end
  
end