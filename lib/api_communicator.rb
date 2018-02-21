require 'rest-client'
require 'json'
require 'pry'

def get_characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def get_character_info(character)
  character_hash = get_characters
  character_hash['results'].each do |character_hash|
    if character_hash['name'].downcase == character
      return get_films(character_hash)
    end
  end
end

def get_films(character_hash)
  character_hash['films'].collect do |url|
    JSON.parse(RestClient.get(url))
  end
end


def list_characters
  get_characters['results'].collect do |character_hash|
    character_hash['name'].downcase
  end
end

def print_characters
  get_characters['results'].each do |character_hash|
    puts character_hash['name']
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film['title']
    puts "Episode #{film['episode_id']}"
    puts "Director: #{film['director']}"
    puts "Producers: #{film['producer']}"
    puts "Released: #{film['release_date']}"
    puts ""
    puts "Opening Crawl:"
    puts film['opening_crawl']
    puts '*' * 25
  end
end

def show_character_movies(character)
  # films_hash = get_character_movies_from_api(character)
  films_hash = get_character_info(character)
  parse_character_movies(films_hash)
end

def run
  input = ""

  while input != 'exit' do
    input = get_character_from_user
    if input == 'list'
      print_characters
      puts ""
    elsif list_characters.include?(input)
      show_character_movies(input)
    elsif input != 'exit'
      puts "Invalid input."
    end
  end
end

## BONUS

#parse_character_movies(get_character_movies_from_api('Luke Skywalker'))

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
