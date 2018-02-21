require "rest-client"
require "json"

def welcome
  puts "Welcome to the Star Wars lookup"
end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  character
end
