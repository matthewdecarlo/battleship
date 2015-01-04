Logo = %q"
  🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️
⚓  _  _  _  _   __     ____  _  _  __ _  __ _    _  _  _  _           🌊️            
🌊 / )( \/ )( \ /  \   / ___)/ )( \(  ( \(  / )  ( \/ )( \/ )          ⚓️
⚓ \ /\ /) __ ((  O )  \___ \) \/ (/    / )  (   / \/ \ )  /_  _  _    🌊️
🌊 (_/\_)\_)(_/ \__/   (____/\____/\_)__)(__\_)  \_)(_/(__/(_)(_)(_)   ⚓
⚓ ________       ________________           ______ _____        ______🌊️
🌊 ___  __ )_____ __  /__  /___  /______________  /____(_)__________  /⚓
⚓ __  __  |  __ `/  __/  __/_  /_  _ \_  ___/_  __ \_  /___  __ \_  / 🌊
🌊 _  /_/ // /_/ // /_ / /_ _  / /  __/(__  )_  / / /  / __  /_/ //_/  ⚓
⚓ /_____/ \__,_/ \__/ \__/ /_/  \___//____/ /_/ /_//_/  _  .___/(_)   🌊
🌊                                                      /_/            ⚓
⚓ a simple game by matthewwho + pacoguy                               🌊
  🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️
"

class Board
  attr_accessor :board, :fleet, :ship_types

  def initialize()
    @board = {}
    @ship_types = {carrier: 5, battleship: 4, cruiser: 3, destroyer: 2, submarine: 1}
    @fleet = []

    gen_board
  end

  def gen_board
    ("A".."J").each do |row|
      (1..10).each { |column| board.merge!( { "#{row}#{column}".to_sym => '1' } ) }
    end

    return board
  end

  def board_array_representation
    final_board_array = []
    board_array = []
    letter = "A"

    board.each_value { |value| board_array << value }
    final_board_array << "    1 2 3 4 5 6 7 8 9 10"
    final_board_array << "  +---------------------+"

    board_array.each_slice(10) do |row|
      final_board_array << "#{letter} | " + row.join(" ").gsub(/["0"]/, '🌊') + " |"
      letter.next!
    end

    final_board_array << "  +---------------------+"

    return final_board_array
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
    self.board.keys.sample
  end

  def has_ship?(a_value)
    a_value == '1'
  end

  def remove_ship!(a_ship)
    self.ships
  end

  def place_ship_horizontaly
    get_random_position
  end

end

class Ship
  attr_accessor :positions
  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @positions = []
  end
end


# class Player
#   # attr_accessor

#   def i nitialize
#   end
# end


## Runner
def display_game(first_board, second_board)
  display = ""
  
  (0..first_board.length).each { |line| display << first_board[line].to_s + "          " + second_board[line].to_s + "\n"}

  return display
end



##TESTS
player_a = Board.new
player_b = Board.new

player_b.gen_fleet
player_b.fleet.each { |object| p "#{object.name} #{object.length}" }
player_b.fleet.length

# p a_ship = Ship.new('carrier', 5)

# puts Logo
# puts
# puts display_game(player_a.board_array_representation, player_b.board_array_representation)

# print player_a.horizontal_ship_placement