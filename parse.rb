# parse the CSV into a sqlite3 database here!

#YEAR,GoogleKnowlege_Occupation,Show,Group,Raw_Guest_List

require "sqlite3"
require 'csv'
#require_relative '/daily_show_guests.csv'

DB = {:conn => SQLite3::Database.new("guests.db")}
DB[:conn].execute("DROP TABLE IF EXISTS guests")

sql = <<-SQL
  CREATE TABLE IF NOT EXISTS guests (
    Year INTEGER,
    Occupation TEXT,
    Show TEXT,
    Type TEXT,
    Name TEXT
  );
SQL

DB[:conn].execute(sql)

CSV.foreach("daily_show_guests.csv") do |row|
  sql = "INSERT INTO guests (Year, Occupation, Show, Type, Name) 
    VALUES (?, ?, ?, ?, ?);"

  DB[:conn].execute(sql, row[0], row[1], row[2], row[3], row[4])
end


 full = DB[:conn].execute( "SELECT DISTINCT name FROM guests 
WHERE name LIKE 'Bill%'")
 

puts full
