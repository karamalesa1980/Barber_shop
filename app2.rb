require 'sqlite3'

db = SQLite3::Database.new 'test.sqlite3'

db.execute "insert into cars(name, price) values('jeep', '5000')"

db.close