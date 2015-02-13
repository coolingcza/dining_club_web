# Class: Person
#
# Models a person with relevant attributes.
#
# Attributes:
# @name    - String: person's name.
# @id      - Number: primary key in people table.
# @club_id - Number: foreign key in people table.
# @table   - String: "people"
#
# Public Methods:
# #where_name
# #where_club_id

class Person
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :id, :table
  attr_accessor :club_id, :name
  
  # Public: .where_name
  # Gets a list of people with the given name.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array containing objects for matching person records.
  
  def self.where_name(x)
    results = DATABASE.execute("SELECT * FROM people WHERE name = '#{x}'")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
  end
  
  # Public: .where_club_id
  # Gets a list of people in the given dining club.
  #
  # Parameters:
  # x - Number: The club id to search for.
  #
  # Returns: Array: Containing matching person objects.
  
  def self.where_club_id(x)
    results = DATABASE.execute("SELECT * FROM people WHERE club_id = #{x}")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
  end
  
  
  def initialize(options)
    @id      = options["id"]
    @name    = options["name"]
    @club_id = options["club_id"]
    @table   = "people"
  end
  
end