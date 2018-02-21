require 'rest-client'
require 'json'
require 'pry'

def get_characters_from_movie(movie)
  all_films = JSON.parse(RestClient.get("http://www.swapi.co/api/films"))
  all_films["results"]
  output = []

  all_films["results"].each do |film_data|
    if film_data["title"].downcase == movie
      output = film_data["characters"]
    end
  end
  character_list = output.collect do |character_page|
    character = JSON.parse(RestClient.get(character_page))
    character["name"]
  end
  character_list
end



def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  output = []
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  character_hash["results"].each do |character_data|
    if character_data["name"].downcase == character
      output = character_data["films"]
    end
  end
  output.collect do |link|
    JSON.parse(RestClient.get(link))
  end
end

def parse_char_name(char_array)
  char_array.each do |name|
    puts "#{name}"
  end
  return ""
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.collect do |movie|
    puts "#{movie["title"]}"
  end
  return ""
end

def show_characters_in_movie(movie)
  char_array = get_characters_from_movie(movie)
  parse_char_name(char_array)
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
