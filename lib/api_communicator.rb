require 'rest-client'
require 'json'
require 'pry'

def character_array
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  count = character_hash["count"]
  num = character_hash["results"].length
  full_array = character_hash["results"]
  until num >= count do
    next_link = character_hash["next"]
    character_hash = JSON.parse(RestClient.get(next_link))
    num += character_hash["results"].length
    full_array.concat(character_hash["results"])
  end
  full_array
end

def movie_array
  film_hash = JSON.parse(RestClient.get('http://www.swapi.co/api/films'))
  count = film_hash["count"]
  num = film_hash["results"].length
  full_array = film_hash["results"]
  until num >= count do
    next_link = film_hash["next"]
    film_hash = JSON.parse(RestClient.get(next_link))
    num += film_hash["results"].length
    full_array.concat(film_hash["results"])
  end
  full_array
end

def get_characters_from_movie(movie, array)
  output = []
  array.each do |film_data|
    if film_data["title"].downcase.include? movie
      output = film_data["characters"]
    end
  end
  if output == []
    puts "Could not find your query."
  end
  output.collect do |character_page|
    character = JSON.parse(RestClient.get(character_page))
    character["name"]
  end
end



def get_character_movies_from_api(character, array)
  #make the web request
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
  array.each do |character_data|
    if character_data["name"].downcase.include? character
      output = character_data["films"]
    end
  end
  if output == []
    puts "Could not find your query. Make sure you are including hyphens"
    puts "ie. 'Obi-Wan Kenobi'"
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
  films_hash.each do |movie|
    puts "#{movie["title"]}"
  end
end

def show_characters_in_movie(movie, array)
  char_array = get_characters_from_movie(movie, array)
  parse_char_name(char_array)
end

def show_character_movies(character, array)
  films_hash = get_character_movies_from_api(character, array)
  parse_character_movies(films_hash)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
