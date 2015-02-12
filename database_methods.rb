module DatabaseClassMethods
  
  def find(table, record_id)
    results = DATABASE.execute("SELECT * FROM #{table} 
                                WHERE id = #{record_id}")
    record_details = results[0] # Hash of the record's details.
    record_details
    self.new(record_details)
  end
  
  def all(table)
    results = DATABASE.execute("SELECT * FROM #{table}")
    puts results
  end
  
end


module DatabaseInstanceMethods
  
  # Take all the attributes for this object and make sure
  # those are the values in this object's corresponding row
  # in the "students" table.
  #

    
  def insert
  
    attributes = []
    instance_variables.each do |i|
      attributes << i.to_s.delete("@") if (i != :@id && i != :@table)
    end
  
    values = []
    attributes.each do |a|
      value = self.send(a)
    
      if value.is_a?(Integer)
        values << "#{value}"
      else values << "'#{value}'"
      end
    end
  
    #binding.pry
  
    DATABASE.execute("INSERT INTO #{@table} (#{attributes.join(", ")}) 
                      VALUES (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id
    #binding.pry
  end

  def save
    attributes = []
    
    # Example  [:@name, :@age, :@hometown]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") if i != :@table
    end
    
    query_components_array = []
    
    attributes.each do |a|
      value = self.send(a)
      
      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end
    
    query_string = query_components_array.join(", ")
    # name = 'Sumeet', age = 75, hometown = 'San Diego'

    DATABASE.execute("UPDATE #{@table} SET #{query_string} WHERE id = #{id}")
  end
  
  def delete
    binding.pry
    DATABASE.execute("DELETE from #{table} WHERE id = #{id}")
  end

  
end