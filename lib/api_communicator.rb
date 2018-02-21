require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  helper(character, character_hash)
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

def helper(character, character_hash)
  character_hash['results'].each do |i|
    if i['name'] == character
      return i["films"]
    else
      "Character does not exist!"
      break
    end
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  n = 0
  films_hash.each do |i|
    url = RestClient.get(i)
    puts "#{n +=1} #{JSON.parse(url)["title"]}"
  end
end

# if i["characters"].include?(url)
#   i["title"]
# end
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
  # binding.pry
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# if i['name'] == character
#   i["films"]
# else
#   puts "Character does not exist!"
#   break
# end
# end
