people = [] # Исходный пустой массив

def add_person(people)
  puts "Введите имя человека:"
  name = gets.chomp
  puts "Введите возраст человека:"
  age = gets.chomp.to_i
  puts "Введите комнату, в которую селят человека:"
  room = gets.chomp.to_i

  person = { name: name, age: age, room: room }
  people << person

  puts "#{name} успешно добавлен в массив."
end

def remove_person(people)
  puts "Введите имя человека, которого нужно удалить:"
  name = gets.chomp

  index = people.find_index { |person| person[:name] == name }

  if index.nil?
    puts "Человек с именем #{name} не найден."
  else
    removed_person = people.delete_at(index)
    puts "#{removed_person[:name]} успешно удален из массива."
  end
end

def print_people(people)
  puts "Список людей:"
  puts "-----------------------------"
  people.each_with_index { |person, index| puts "#{index + 1}. #{person[:name]}, возраст #{person[:age]}, комната #{person[:room]}" }
  puts "-----------------------------"
end



loop do
  puts "Выберите действие:"
	puts "-----------------------------"
  puts "1. Добавить человека"
	
  puts "2. Удалить человека"
	
  puts "3. Вывести список людей"
	
  puts "4. Выйти"
	
4
  choice = gets.chomp.to_i

  case choice
  when 1
    add_person(people)
  when 2
    remove_person(people)
  when 3
    print_people(people)
  when 4
    break
  else
    puts "Некорректный выбор. Попробуйте еще раз."
  end
end
