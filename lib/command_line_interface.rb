def welcome
  puts "Welcome!"
end

def get_character_from_user
  puts "please enter a character name, 'list' to see valid character names, or 'exit' to exit the program."
  user_input = gets.chomp
  user_input.downcase
end
