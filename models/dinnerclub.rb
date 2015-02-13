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
  # Returns: Array that contains objects for matching dinner club records.
  
  def self.where_name(x)
    results = DATABASE.execute("SELECT * FROM dinnerclubs WHERE name = '#{x}'")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    results_as_objects
  end
  
  # Public: #initialize
  # Creates DinnerClub object.
  #
  # Parameters:
  # @name  - Array: contains member names.
  # @id    - Number: derived from dinnerclubs table primary key.
  # @table - String: "dinnerclubs" - name of associated table
  #
  # Returns:
  # DinnerClub object.
  #
  # State Changes:
  # New object created.
  
  def initialize(options)
    @name = options["name"]
    @id   = options["id"]
    @table = "dinnerclubs"
  end
  
  
end
