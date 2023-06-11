require 'bundler/setup'
Bundler.require
require 'sqlite3'

# Connection to the database
db = SQLite3::Database.new('board.db')

# Creating the "board" table (if it doesn't exist)
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS board (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255)
  );
SQL

def add_board(db)
  puts "Enter a list of words separated by commas:"
  names = gets.chomp.downcase.split(",").map(&:strip)

  added_names = Set.new
  existing_names = Set.new(db.execute("SELECT name FROM board").flatten.map(&:downcase))

  names.each do |name|
    next if added_names.include?(name) || existing_names.include?(name)

    db.execute("INSERT INTO board (name) VALUES (?)", name)
    puts "#{name} has been successfully added to the database."
    added_names << name
  end
end

puts "--------------------------------------------------------------------------"
def print_board(db)
  puts "Word list:"
  board = db.execute("SELECT name FROM board")
  board.each_with_index { |row, index| puts "#{index + 1}. #{row[0]}" }
	puts "--------------------------------------------------------------------------"
end

def remove_duplicates(db)
  db.execute("UPDATE board SET name = TRIM(name)")

  db.execute <<-SQL
    DELETE FROM board
    WHERE id NOT IN (
      SELECT MIN(id)
      FROM board
      GROUP BY LOWER(name)
    )
  SQL

  puts "Duplicate words have been removed from the database."
end



loop do
  puts "Select an action:"
  puts "1. Add words"
  puts "2. Print word list"
  puts "3. Remove duplicates"
  puts "4. Exit"
	puts "--------------------------------------------------------------------------"
  choice = gets.chomp.to_i

  case choice
  when 1
    add_board(db)
  when 2
    print_board(db)
  when 3
    remove_duplicates(db)
  when 4
    break
  else
    puts "Invalid choice. Please try again."
  end
end
