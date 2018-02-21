def welcome
  # puts out a welcome message here!
  puts "Welcome user, please enter a character name you would like to search for:"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp
  character
end
