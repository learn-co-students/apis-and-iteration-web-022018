require 'rest-client'
require 'json'
require 'pry'


# a hash of character name => { character info }
def fetch_characters
  #make the web request
  result = fetch_and_parse('http://www.swapi.co/api/people/')
  result['results']
end

def fetch_and_parse(url)
  JSON.parse(RestClient.get(url))
end

def get_film_info(url)
  fetch_and_parse(url)
end

def character_info(character_name)
  fetch_characters.find { |c| c['name'].include?(character_name) }
end

def movies_hashes_for(character_name)
  c_info = character_info(character_name)
  film_info_array = c_info['films'].map do |url|
    get_film_info(url)
  end
end

def print_movies(film_info_array)
  # some iteration magic to puts out the movies in a nice list
  film_info_array.sort_by { |film| film['episode_id'] }.each do |film_hash|
    puts "Episode #{film_hash['episode_id']}: #{film_hash['title']}"
  end
end

def show_character_movies(character_name)
  movie_hashes = movies_hashes_for(character_name)
  print_movies(movie_hashes)
end
