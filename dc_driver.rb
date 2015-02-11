require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new("dinnerclub.db")

require_relative "database_setup.rb"
require_relative "database_methods.rb"
require_relative "dinnerclub.rb"
require_relative "person.rb"
require_relative "event.rb"
require_relative "checksplitter.rb"


puts " "

puts "Welcome to the Dinner Club Management System"

puts "--------------------------------------------"
puts " "
puts "Menu of Operations:"
puts "1. Create New Club"
puts "2. View Existing Club Information"
puts "3. Edit Existing Club Information"
#add in events if/when
puts " "
puts "Enter your selection:"

selection = gets.chomp.to_i

if selection == 1  #Create New Club
  puts " Enter Club name:"
  club_name = gets.chomp
  puts " "

  new_club = DinnerClub.new({"name" => club_name})#, members: members})
  new_club.insert
  
  puts " Enter Club member names, separated by commas:"
  input = gets.chomp
  members = input.split", "
  
  members.each do |m| 
    p = Person.new({"name" => m, "club_id" => new_club.id})
    p.insert
  end
  
  puts " "
  puts "New Club, #{club_name}, created:"
  puts DinnerClub.find("dinnerclub",new_club.id)
  puts "with members:"
  puts Person.where_club_id(new_club.id)
  
elsif selection == 2  #View existing club info
  puts " Enter Club attribute to search by:"
  puts " 1. Club Name"
  puts " 2. Club ID Number"
  puts " Enter your selection:"
  
  sel2 = gets.chomp.to_i
  
  if sel2 == 1
    puts " Enter Club Name:"
    club_name = gets.chomp
    dc_results = DinnerClub.where_name(club_name)
    puts " "
    puts "Club name: #{dc_results.name}"
    puts "Members:"
    p_results = Person.where_club_id(dc_results[0].id)
    p_results.each {|p| puts p.name }
    
  elsif sel2 == 2
    puts " Enter Club ID:"
    club_id = gets.chomp.to_i
    dc_results = DinnerClub.find("dinnerclub",club_id)
    puts " "
    puts "Club name: #{dc_results.name}"
    puts "Members:"
    p_results = Person.where_club_id(club_id)
    p_results.each {|p| puts p.name }
    
  end
  
elsif selection == 3  #Edit existing club info
  puts "Enter Club attribute to search by:"
  puts "1. Club Name"
  puts "2. Club ID"
  puts " Enter your selection:"
  
  sel3 = gets.chomp.to_i
  
  if sel3 == 1
    puts " Enter Club Name:"
    club_name = gets.chomp
    dc_results = DinnerClub.where_name(club_name)
    $editclub = dc_results[0]
    
  elsif sel3 == 2
    puts " Enter Club ID:"
    club_id = gets.chomp.to_i
    dc_results = DinnerClub.find("dinnerclub",club_id)
    $editclub = dc_results
    
  end
  
  puts "Accessing Club #{$editclub.name}..."
  editmembers = Person.where_club_id($editclub.id)
  puts "Members:"
  puts "-------"
  editmemhash = {}
  editmembers.each do |m|
    puts " #{m.name}"
    editmemhash[m.name] = m
  end
  
  #stuff to do:
  # ask whether to edit club name member names, add or remove members?
  puts "Edit Options:"
  puts "------------"
  puts "1. Edit Club Name"
  puts "2. Edit Member Names"
  puts "3. Add Members"
  puts "4. Remove Members"
  puts " "
  #puts "return to main menu?"
  puts "Enter selection:"
  
  sel4 = gets.chomp.to_i
  
  if sel4 == 1
    puts "Enter new Club name:"
    new_name = gets.chomp
    $editclub.name = new_name
    $editclub.save
    
  elsif sel4 == 2
    puts "Which Member Name would you like to change?"
    oldname = gets.chomp
    mem = editmemhash[oldname]
    puts "Enter Member's new name:"
    newname = gets.chomp
    mem.name = newname
    mem.save
    
  elsif sel4 == 3
    puts "Enter new member names separated by commas:"
    input = gets.chomp
    members = input.split", "
  
    members.each do |m| 
      p = Person.new({"name" => m, "club_id" => $editclub.id})
      p.insert
    end
  
    puts " "
    puts "#{$editclub.name}, edited."
    puts "New member list:"
    newlist = Person.where_club_id($editclub.id)
    newlist.each{ |p| puts p.name }
    
  elsif sel4 == 4
    puts editmemhash
    puts "Which member would you like to remove?"
    membr = gets.chomp
    editmemhash[membr].delete
    puts "Member removed."
    puts "New member list:"
    p_list = Person.where_club_id($editclub.id)
    p_list.each { |p| puts p.name }
    
    
  end
  
  
  
end
  
  
# event init: {attendees, destination, bill, club_id, treat=false}


# group = DinnerClub.new("Sally","Mark","John","Claire","Jim","Sunny")
#
# party = Event.new(["Sally","Mark","John","Claire","Jim","Sunny"], "Granite City", 120.45)
#
# lunch = Event.new(["Mark","Claire","Sunny","Bob"], "Chilis", 36.8, true)
#
# holiday = Event.new(["Sally","Mark","John","Jim","Sunny"], "Silverthorn", 346.4)

binding.pry
