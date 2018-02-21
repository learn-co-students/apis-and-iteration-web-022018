require 'rest-client'
require 'json'
require 'pry'

def api_pull
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters = []
  characters << character_hash['results']

until character_hash['next'] == nil

          all_characters = RestClient.get("#{character_hash['next']}")
            character_hash = JSON.parse(all_characters)

            characters << character_hash['results']

 end
characters.flatten!
end


def get_character_movies_from_api(character)
api_pull.each do|person|
  # binding.pry
    if person['name'].downcase == character.downcase
      return person['films']

    end
end
return nil

end

def parse_character_movies(films_hash)
  #films hash is an array
  #iterate through each array & pull film title.
films_hash.each do |links|
movies = RestClient.get("#{links}")
p_movies = JSON.parse(movies)
puts %Q["#{p_movies['title']}"]


end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash.nil?
    puts "That's not a star wars character!"
    exit
  end
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
