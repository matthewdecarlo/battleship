Logo = %q"
  🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓
⚓  _  _  _  _   __     ____  _  _  __ _  __ _    _  _  _  _            🌊️            
🌊 / )( \/ )( \ /  \   / ___)/ )( \(  ( \(  / )  ( \/ )( \/ )           ⚓️
⚓ \ /\ /) __ ((  O )  \___ \) \/ (/    / )  (   / \/ \ )  /_  _  _     🌊️
🌊 (_/\_)\_)(_/ \__/   (____/\____/\_)__)(__\_)  \_)(_/(__/(_)(_)(_)    ⚓
⚓ ________       ________________           ______ _____        ______ 🌊️
🌊 ___  __ )_____ __  /__  /___  /______________  /____(_)__________  / ⚓
⚓ __  __  |  __ `/  __/  __/_  /_  _ \_  ___/_  __ \_  /___  __ \_  /  🌊
🌊 _  /_/ // /_/ // /_ / /_ _  / /  __/(__  )_  / / /  / __  /_/ //_/   ⚓
⚓ /_____/ \__,_/ \__/ \__/ /_/  \___//____/ /_/ /_//_/  _  .___/(_)    🌊
🌊                                                      /_/             ⚓
⚓ a simple game by matthewwho                                          🌊
  🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓️
"

class Board
  attr_accessor :board

  def initialize()
    @board = {}

    gen_board
  end

  def gen_board
    ("A".."J").each do |row|
      (1..10).each { |column| board.merge!( { "#{row}#{column}".to_sym => '🌊' } ) }
    end

    return board
  end

  def board_array_representation
    board_string = []
    board_array = []
    letter = "A"

    board.each_value { |value| board_array << value }
    board_string << "    1  2  3  4  5  6  7  8  9  10  "
    board_string << "  +-------------------------------+"

    board_array.each_slice(10) do |row|
      board_string << "#{letter} | " + row.join(" ").gsub(/["0"]/, '_') + " |"
      letter.next!
    end

    board_string << "  +-------------------------------+"

    return board_string
  end
end

def display_game(first_board, second_board)
  display = ""
  
  (0..first_board.length).each { |line| display << first_board[line].to_s + "          " + second_board[line].to_s + "\n"}

  return display
end

player_a = Board.new
player_b = Board.new

puts Logo
puts
puts display_game(player_a.board_array_representation, player_b.board_array_representation)