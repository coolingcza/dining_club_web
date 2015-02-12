# Class: CheckSplitter
#
# Given a single bill, calculates restaurant tab for member of large party including tip.
#
# Attributes:
# @bill       - Float: bill for entire group.
# @tip        - Integer: percent tip to leave. Default: 15.
# @party_size - Integer: number of people in the party.
#
# Public Methods:
# #total_bill
# #per_person

class CheckSplitter
  
  attr_reader :tip, :bill, :party_size, :per_person, :total_bill, :event_id
  
  def initialize(bill, tip=15, party_size, event_id)
    @bill = bill
    @tip = tip
    @party_size = party_size
    @event_id = event_id
    #puts @event_id
  end
  
  # Public: #total_bill
  # Calculates the bill plus tip.
  #
  # Parameters:
  # bill - bill for entire group.
  # tip  - decimal tip number.
  #
  # Returns:
  # total_bill: bill including tip.
  #
  # State Changes:
  # None.
  
  def total_bill
    @total_bill = (@bill * (1 + @tip/100.0)*100.0).ceil.to_i
    @total_bill = @total_bill/100.0
  end
  
  # Public: #per_person
  # Returns amount of tab for each member of dining party.
  #
  # Parameters:
  # total_bill - Return from total_bill method.
  # party_size - Integer: size of dining party.
  #
  # Returns:
  # Per_person: tab per party member.
  #
  # State Changes:
  # None.
  
  def per_person
    @per_person = (total_bill / @party_size).ceil.to_i
  end
  
  def insert
    DATABASE.execute("INSERT INTO checks 
    (event_id, bill, total_bill, bill_per_person, tip) 
    VALUES 
    (#{event_id}, #{bill}, #{total_bill}, #{per_person}, #{tip})")
  end
  
  def self.all
    DATABASE.execute("SELECT * FROM checks")
  end
  
end