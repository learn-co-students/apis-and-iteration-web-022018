require 'rest-client'
require 'json'
require 'pry'

def get_characters()
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def get_films(character_hash)
  character_hash["films"].collect do |url|
    JSON.parse(RestClient.get(url))
  end
end

def get_character_movies_from_api(character)
  get_characters["results"].each do |character_hash|
    if character_hash["name"].downcase == character
      return get_films(character_hash)
    end
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts film['title']
    puts "Episode: #{film['episode_id']}"
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
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def list()
  get_characters["results"].each do |character_hash|
    puts character_hash["name"]
  end
end

def return_list()
  get_characters["results"].collect do |character_hash|
    character_hash["name"].downcase
  end
end

def run()
  loop do
    character = get_character_from_user
    if character == 'list'
      list()
    elsif character == 'exit'
      puts "Goodbye!"
      break
    elsif (return_list().include? character)
      show_character_movies(character)
    else
      puts "Invalid Character!"
    end
  end
end
