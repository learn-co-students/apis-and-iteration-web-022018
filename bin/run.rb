#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
loop do
  puts "Please enter a command."
  input = gets.chomp
  case input
  when "character"
    puts "*" * 25
    character = get_character_from_user
    show_character_movies(character)
    puts "*" * 25
  when "movie"
    puts "*" * 25
    movie = get_movie_from_user
    show_characters_in_movie(movie)
    puts "*" * 25
  when "exit"
    puts "Farewell"
    break
  end
end
