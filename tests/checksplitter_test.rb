require "pry"
require "SQLite3"
require "minitest/autorun"

DATABASE = SQLite3::Database.new('dinnerclubweb_test.db')

require_relative "../database/database_setup"
require_relative "../database/database_methods"
require_relative "../models/dinnerclub"
require_relative "../models/person"

#testclub = DATABASE.execute("INSERT INTO dinnerclubs (name) VALUES 'testname'")

class DinnerClubTest < Minitest::Test
    
  def test_dc_confirm_insert
    group = DinnerClub.new({"name"=>"Test Name"})
    group.insert
    a = DATABASE.execute("SELECT * FROM dinnerclubs WHERE name = 'Test Name'")
    assert(a)
  end
  
  def test_dc_where_name
    group = DinnerClub.where_name("Test Name")
    a = DATABASE.execute("SELECT * FROM dinnerclubs WHERE name = 'Test Name'")
    assert(a)
  end
  
  def test_dc_save
    group = DinnerClub.find("dinnerclubs",1)
    group.name = "Biplane"
    group.save
    group = DinnerClub.find("dinnerclubs",1)
    assert_equal("Biplane",group.name)
  end
  
  def test_dc_find
    group1 = DATABASE.execute("SELECT * FROM dinnerclubs WHERE id = 1")
    group2 = DinnerClub.find("dinnerclubs",1)
    assert_equal(group2.name,group1[0]["name"])
  end
  
  def test_dc_where_attr
    n = DinnerClub.new({"name"=>"Firehouse"})
    n.insert
    a = DATABASE.execute("SELECT * FROM dinnerclubs WHERE name = 'Firehouse'") #array of hashes
    b = DinnerClub.where_attr("dinnerclubs","name","Firehouse") #array of objs
    aname = a[0]["name"]
    bname = b[0].name
    assert(bname,aname)
  end
  
  def test_dc_all
    a = DATABASE.execute("SELECT * FROM dinnerclubs")
    b = DinnerClub.all("dinnerclubs")
    assert_equal(b.length,a.length)
  end
  
end

class PersonTest < Minitest::Test
  
  def test_person_insert
    sam=Person.new({"name"=>"Sam","club_id"=>1})
    sam.insert
    sam_ex = DATABASE.execute("SELECT * FROM people WHERE name = 'Sam'")
    assert(sam_ex)
    
  end
  
  def test_person_where_name
    group = Person.where_name("Sam")
    a = DATABASE.execute("SELECT * FROM people WHERE name = 'Sam'")
    assert_equal(group[0].name,a[0]["name"])
  end
  
  def test_person_where_club_id
    group = Person.where_club_id(1)
    a = DATABASE.execute("SELECT * FROM people WHERE club_id = 1")
    assert_equal(group[0].club_id,a[0]["club_id"])
  end
  
end


