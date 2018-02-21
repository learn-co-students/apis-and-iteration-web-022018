#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
char_array = character_array
mov_array = movie_array
puts character_array
loop do
  puts "Please enter a command."
  input = gets.chomp
  case input
  when "character"
    puts "*" * 25
    character = get_character_from_user
    show_character_movies(character, char_array)
    puts "*" * 25
  when "movie"
    puts "*" * 25
    movie = get_movie_from_user
    show_characters_in_movie(movie, mov_array)
    puts "*" * 25
  when "exit"
    puts "Farewell"
    break
  end
end
