
DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS people 
                  (id INTEGER PRIMARY KEY, name TEXT, club_id INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS events
                  (id INTEGER PRIMARY KEY, restaurant TEXT, club_id INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS checks 
                  (id INTEGER PRIMARY KEY, event_id INTEGER, bill CURRENCY,
                  total_bill CURRENCY, bill_per_person CURRENCY, tip INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS eventattend
                  (event_id INTEGER, person_id INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS dinnerclubs
                  (id INTEGER PRIMARY KEY, name TEXT)")
                  
                  