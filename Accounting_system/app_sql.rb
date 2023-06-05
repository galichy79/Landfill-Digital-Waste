require 'sqlite3'

# Подключение к базе данных
db = SQLite3::Database.new('people.db')

# Создание таблицы "people" (если она еще не существует)
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    age INTEGER
  );
SQL

def add_person(db)
  puts "Введите имя человека:"
  name = gets.chomp
  puts "Введите возраст человека:"
  age = gets.chomp.to_i

  # Вставка данных в таблицу "people"
  db.execute("INSERT INTO people (name, age) VALUES (?, ?)", [name, age])

  puts "#{name} успешно добавлен в базу данных."
end

def remove_person(db)
  puts "Введите имя человека, которого нужно удалить:"
  name = gets.chomp

  # Удаление человека из таблицы "people"
  db.execute("DELETE FROM people WHERE name = ?", [name])

  puts "#{name} успешно удален из базы данных."
end

def print_people(db)
  puts "Список людей:"
  people = db.execute("SELECT * FROM people")
  people.each { |person| puts "#{person[1]}, возраст #{person[2]}" }
end

loop do
  puts "Выберите действие:"
  puts "1. Добавить человека"
  puts "2. Удалить человека"
  puts "3. Вывести список людей"
  puts "4. Выйти"

  choice = gets.chomp.to_i

  case choice
  when 1
    add_person(db)
  when 2
    remove_person(db)
  when 3
    print_people(db)
  when 4
    break
  else
    puts "Некорректный выбор. Попробуйте еще раз."
  end
end
