# Class: DinnerClub
#
# Models a dinner club that includes a number of diners.
#
# Attributes:
# @name  - String: contains club name.
# @id    - Number: id number associated with primary key in dinnerclubs table.
# @table - String: "dinnerclubs"
# 
# Public Methods:
# #where_name

class DinnerClub
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :id, :table
  attr_accessor :name
  
  # Public: .where_name
  # Get a list of dinner clubs with the given name.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array: Containing matching dinner club records.
  
  def self.where_name(x)
    results = DATABASE.execute("SELECT * FROM dinnerclubs WHERE name = '#{x}'")

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
    @table = "dinnerclubs"
  end
  
  
end
