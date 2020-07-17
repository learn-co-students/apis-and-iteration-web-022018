require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash['results'].each do |x|
    films_hash = character_hash['results'][0]['films'] if x['name'] == character
  end
end

def parse_character_movies(films_hash)
  array = []
  films_hash[0]['films'].each do |x|
    films_data = RestClient.get(x)
    films_parse = JSON.parse(films_data)
    array << films_parse['title']
  end
  array.each.with_index(1) do |x, index| puts "#{index}. #{x}" end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
