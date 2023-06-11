require 'sqlite3'

# Устанавливаем соединение с базой данных
db = SQLite3::Database.new('database.db')

# Создаем таблицу, если она еще не существует
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS words (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word TEXT
  );
SQL

# Метод для добавления списка слов в базу данных
def add_words_to_database(words, db)
  words.each do |word|
    db.execute("INSERT INTO words (word) VALUES (?)", word)
  end
end

# Пример списка слов для добавления
word_list = ['apple', 'banana', 'carrot', 'dog']

# Вызываем метод для добавления списка слов в базу данных
add_words_to_database(word_list, db)

# Закрываем соединение с базой данных
db.close
