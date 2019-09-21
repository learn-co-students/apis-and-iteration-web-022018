require_relative "../lib/command_line_interface.rb"
require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  names = character_hash["results"]

  films = []
  names.each do |details|
    if details["name"].downcase == character
      details["films"].each do |film|
        one_film = RestClient.get(film)
        one_film_hash = JSON.parse(one_film)
        films << one_film_hash
      end
    end
  end
  while films.empty?
    character = get_character_from_user
    show_character_movies(character)
  end
    parse_character_movies(films)
end

def parse_character_movies(films_hash)
  titles = []
  films_hash.each do |film|
    titles << film["title"]
   end
   puts titles
   titles
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  # parse_character_movies(films_hash)
end
## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
