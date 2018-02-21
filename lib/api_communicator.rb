require 'rest-client'
require 'json'
require 'pry'

all_characters = RestClient.get('http://www.swapi.co/api/people/')
character_hash = JSON.parse(all_characters)
films = []

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films = []

  character_hash["results"].each do |characters|
    if characters["name"].downcase == character
      films = (characters["films"])
    end
  end

  films.map do |film|
    JSON.parse(RestClient.get(film))
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  count = 1
  films_hash.map do |movie|
    puts "'#{count} #{movie["title"]}'"
    count += 1
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash == []
    puts "That character is not in a Star Wars film!"
  else
    parse_character_movies(films_hash)
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
