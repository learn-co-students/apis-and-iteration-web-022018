require "rest-client"
require "json"

def get_character_movies_from_api(character)

  page = 1
  stop = 0
  out = []

  while stop == 0

    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{page}")
    character_hash = JSON.parse(all_characters)

    if character_hash["next"] == nil
      stop = 1
    end

    character_hash["results"].each do |chars|

      if chars["name"] == character
        movies = chars["films"]

        movies.each do |movieurl|
          film = all_characters = RestClient.get("#{movieurl}")
          film_hash = JSON.parse(film)
          out << film_hash
        end
        return out

      end
    end
    page += 1
  end
  puts "Sorry, character not found."
  out
end

def parse_character_movies(films_hash)

  if films_hash.length > 0
    movienum = 1
    films_hash.each do |film|
      puts "#{movienum}. #{film["title"]}"
      movienum += 1
    end
  else
    puts "There are no movies."
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
