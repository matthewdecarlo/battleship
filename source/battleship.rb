class Board
  attr_accessor :board_hash, :fleet, :ship_types

  def initialize()
    @board_hash = {}
    @ship_types = {carrier: 5, battleship: 4, cruiser: 3, destroyer: 2, submarine: 1}
    @fleet = []

    gen_board
  end

  def gen_board
    ("A".."J").each do |row|
      (0..9).each { |column| board_hash.merge!( { "#{row}#{column}".to_sym => '0' } ) }
    end

    return board_hash
  end

  def board_array_representation
    final_board_array = []
    board_array = []
    letter = "A"

    board_hash.each_value { |value| board_array << value }
    final_board_array << "    1 2 3 4 5 6 7 8 9 10 "
    final_board_array << "  +---------------------+"

    board_array.each_slice(10) do |row|
      final_board_array << "#{letter} | " + row.join(" ").gsub(/[012HM]/, '0' => '🌊', '1' => '🚢', '2' => '‼️', 'H' => '🔥', 'M' => '🐠') + " |"
      letter.next!
    end

    final_board_array << "  +---------------------+"

    return final_board_array
  end

  def get_value(key)
    board_hash[key]
  end

  def set_value(key, value)
    board_hash[key, value]
  end

  def hit?(value)
    get_value(value) == '1' or get_value(value) == '2'
  end

  def gen_fleet
    fleet_composition = {carrier: 1, battleship: 1, cruiser: 1, destroyer: 3, submarine: 3}

    while fleet_composition.length != 0
      fleet_composition.each do |key, value|
        if value == 1
          a_ship = key
          fleet_composition.delete(key)
          fleet << Ship.new(a_ship.to_s, ship_types[a_ship])
        else
          a_ship = key
          fleet_composition[key] -= 1
          fleet << Ship.new(a_ship.to_s, ship_types[a_ship])
        end
      end
    end
  end

  def get_random_position
    self.board_hash.keys.sample
  end

  def possible_postion?(a_key)
    board_hash.has_key?(a_key)
  end

  def position_empty?(a_key)
    checks = []

    fleet.each { |ship| checks << ship.positions.include?(a_key) }

    checks.include?(true)
  end

  def ship_postions_empty?(range)
    occupied = []
    range.each { |key| occupied << position_empty?(key)}

    occupied.include?(true) ? false : true
  end

  def gen_range(start_position, end_position, direction)
    horizontal_letter = start_position[0]
    vertical_number = start_position[1]
    range = []

    case direction
    when 'horizontal'
      (start_position[1].to_i .. end_position[1].to_i).each { |number| range << (horizontal_letter + number.to_s).to_sym }
    when 'vertical'
      (start_position[0] .. end_position[0]).each { |letter| range << (letter + vertical_number).to_sym }
    end

    return range
  end

  def place_ship_horizontaly(a_ship)
    while ship_not_placed?(a_ship)

    start_position = get_random_position.to_s
    end_position = start_position.chars

    end_position[1] = ( end_position[1].to_i + (a_ship.length - 1) )
    end_position = end_position.join


      if possible_postion?(end_position.to_sym)
        a_range = gen_range(start_position, end_position, 'horizontal')

        a_ship.positions = a_range if ship_postions_empty?(a_range)   
      end
    end
  end

  def place_ship_verticaly(a_ship)
    while ship_not_placed?(a_ship)

    start_position = get_random_position.to_s
    letter = start_position[0]

    (a_ship.length - 1).times { letter.next! }

    end_position = letter + start_position[1]

      if possible_postion?(end_position.to_sym)
        a_range = gen_range(start_position, end_position, 'vertical')

        a_ship.positions = a_range if ship_postions_empty?(a_range)   
      end
    end
  end

  def random_direction
    ['horizontal', 'vertical'].sample
  end

  def ship_not_placed?(a_ship)
    a_ship.positions.empty?
  end

  def assign_fleet
    fleet.each do |a_ship|
      case random_direction
      when 'horizontal'
        place_ship_horizontaly(a_ship)
      when 'vertical'
        place_ship_verticaly(a_ship)
      end
    end
  end

  def place_fleet(player)
    fleet.each do |a_ship|
     a_ship.positions.each { |key| board_hash[key] = (player)}
   end
  end

end

class Ship
  attr_accessor :positions
  attr_reader   :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @positions = []
  end
end

class Player
  @@player_count = 0

  attr_accessor :board
  attr_reader   :name , :number

  def initialize(name)
    @name = name
    @board = Board.new

    @@player_count += 1

    @number = @@player_count
  end

  def attack(opponent, position)
    row = position[0]
    column = position.length == 2 ? position[-1] : position[-2..-1]
    column = (column.to_i - 1).to_s
    position = (row + column).upcase.to_sym

    if opponent.board.possible_postion?(position)
      opponent.board.board_hash[position] =  opponent.board.hit?(position) ? 'H' : 'M'
    end
  end

  def random_attack(opponent)
    attack(opponent, board.get_random_position)
  end

  def get_input
    gets.chomp
  end
end