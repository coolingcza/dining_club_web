# Class: Person
#
# Models a person with relevant attributes.
#
# Attributes:
# @name         - String: person's name.
# @spending_amt - Number: zero at initialization.
# @destinations - Array: emtpy at initialization.
#
# Public Methods:
# #spend
# #places

class Person
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :id, :table
  attr_accessor :club_id, :name
  
  # Public: .where_name
  # Get a list of people with the given name.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array: Containing matching person records.
  
  def self.where_name(x)
    results = DATABASE.execute("SELECT * FROM person WHERE name = '#{x}'")

    # results_as_objects = []
    #
    # results.each do |r|
    #   results_as_objects << self.new(r)
    # end
    #
    # results_as_objects
    
    results
  end
  
  # Public: .where_club_id
  # Get a list of people in the given dining club.
  #
  # Parameters:
  # x - Number: The club id to search for.
  #
  # Returns: Array: Containing matching person objects.
  
  def self.where_club_id(x)
    results = DATABASE.execute("SELECT * FROM person WHERE club_id = #{x}")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
  end
  
  # Public: .find
  # Fetch a given record from the 'students' table.
  #
  # Parameters:
  # record_id - Integer: The student's ID in the table.
  #
  # Returns: Array: Containing hopefully just one row (as a Hash).
  
  # def self.find(record_id)
  #   results = DATABASE.execute("SELECT * FROM person WHERE id = #{record_id}")
  #   record_details = results[0] # Hash of the record's details.
  #   record_details
  #   #self.new(record_details)
  # end
  
  def initialize(options) #name, club_id)
    @id      = options["id"]
    @name    = options["name"]
    @club_id = options["club_id"]
    @table   = "person"
    #@spending_amt = 0
    #@destinations = []

  end
  
  # def insert
  #   DATABASE.execute("INSERT INTO person (name, club_id)
  #                     VALUES ('#{name}', #{club_id})")
  #   @id = DATABASE.last_insert_row_id
  #
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
  #   DATABASE.execute("UPDATE person SET #{query_string} WHERE id = #{id}")
  # end
  
  # Public: #spend
  # Adds amt parameter to @spending_amt.
  #
  # Parameters:
  # amt - Number: person's bill from Dining Club Event.
  #
  # Returns:
  # Updated @spending_amt.
  #
  # State Changes:
  # Increases @spending_amt.
  
  def spend(amt)
    @spending_amt += amt
  end
  
  # Public: #places
  # Adds location to @destinations array.
  #
  # Parameters:
  # dest - String: location of Dining Club Event.
  #
  # Returns:
  # Updated @destinations.
  #
  # State Changes:
  # Updates @destinations.
  
  def places(dest)
    @destinations << dest
  end
  
  
  
end