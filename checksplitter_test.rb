require_relative "checksplitter"
require "minitest/autorun"

class CheckSplitterTest < Minitest::Test
  
  #cs = CheckSplitter.new(35.4,20,3)
  
  def test_per_person
    cs = CheckSplitter.new(35.4,20,3)
    assert_in_delta 14.16, cs.per_person, 1
  end
  
  def test_total_bill
    cs = CheckSplitter.new(35.4,20,3)
    assert_in_delta 42.48, cs.total_bill, 1
  end
  
  
end

class EventTest < Minitest::Test
  
  def test_event
    party = Event.new(["Bill","Charlie"],"Destination",35.4)
    assert_kind_of Array, party.attendees
  end
  
end

class DinnerClubTest < Minitest::Test
  
  def test_hash_gen
    group = DinnerClub.new(["Bill","Charlie"])
    refute_nil group.member_list
  end
  
  
end

class PersonTest < Minitest::Test
  
  def test_person_destinations
    sam=Person.new("Sam")
    assert_equal 0, sam.destinations.length
  end
  
end


