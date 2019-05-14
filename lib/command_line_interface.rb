def welcome
  # puts out a welcome message here!
  "Welcome!"
end

def get_character_from_user
  puts "Please enter a character, 'list', or 'exit':"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp.downcase
end
