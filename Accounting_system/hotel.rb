class Hotel
  def initialize
    @rooms = {}
  end

  def add_room(room_number)
    @rooms[room_number] = nil
  end

  def check_in(room_number, guest_name)
    if @rooms[room_number].nil?
      @rooms[room_number] = guest_name
      puts "#{guest_name} checked into room #{room_number}."
    else
      puts "Room #{room_number} is already occupied."
    end
  end

  def check_out(room_number)
    if @rooms[room_number].nil?
      puts "Room #{room_number} is already vacant."
    else
      guest_name = @rooms[room_number]
      @rooms[room_number] = nil
      puts "#{guest_name} checked out from room #{room_number}."
    end
  end

  def list_guests
    @rooms.each do |room_number, guest_name|
      if guest_name.nil?
        puts "Room #{room_number}: Vacant"
      else
        puts "Room #{room_number}: #{guest_name}"
      end
    end
  end
end

# Пример использования

hotel = Hotel.new

# Добавляем комнаты
hotel.add_room(101)
hotel.add_room(102)
hotel.add_room(103)

# Поселение гостей
hotel.check_in(101, "John Doe")
hotel.check_in(102, "Jane Smith")
hotel.check_in(103, "Bob Johnson")
hotel.check_in(103, "Alice Brown") # Пытаемся заселиться в уже занятую комнату

# Выводим список жильцов
hotel.list_guests

# Выселение гостей
hotel.check_out(102)
hotel.check_out(104) # Пытаемся выселиться из несуществующей комнаты

# Выводим обновленный список жильцов
hotel.list_guests
