require_relative 'battleship'

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
⚓ a simple game by matthewwho                                         🌊
  🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓️ 🌊 ⚓ ️🌊 ⚓ ️🌊 ⚓️
"

def display_game(player_1, player_2)
  display = "          #{player_1.name}" + " " * (35 - player_1.name.length) + "#{player_2.name}\n"
  
  (0..player_1.board.board_array_representation.length).each { |line| display << player_1.board.board_array_representation[line].to_s + "          " + player_2.board.board_array_representation[line].to_s + "\n"}

  return display
end

def prompt_player
	'Where would you like to attack: '
end

def clear_screen
	system 'clear'
end

def game_over?(player_1, player_2)
	player_1.board.board_hash.values.count('H') == 21 or player_2.board.board_hash.values.count('H') == 21
end

puts Logo
puts
print 'Please enter your name: '

# Set board
player_1 = Player.new(gets.chomp)
player_2 = Player.new('Dumb AI')

player_1.board.gen_fleet
player_1.board.assign_fleet
player_1.board.place_fleet('1')

player_2.board.gen_fleet
player_2.board.assign_fleet
player_2.board.place_fleet('2')

until game_over?(player_1, player_2)
	clear_screen
	puts
	puts Logo
	puts
	puts display_game(player_1, player_2)

	print prompt_player
	player_1.attack(player_2, player_1.get_input)

	clear_screen
	puts 
	puts Logo
	puts
	puts display_game(player_1, player_2)

	break if game_over?(player_1, player_2)

	puts 'Computer is taking its turn'
	sleep(1)

	player_2.random_attack(player_1)
end

puts

if player_2.board.board_hash.values.count('H') == 21
	puts "Congratulations Captain #{player_1.name} your commanding abilities led your country to victory!"
else
	puts "Sadly, #{player_1.name}, #{player_2.name}'s strategy worked better.\nRemember #{player_2.name} may have won the battle, but not the war!"
end