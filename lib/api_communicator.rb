require 'rest-client'
require 'json'
require 'pry'

def get_characters(url)
  all_characters = RestClient.get(url)
  JSON.parse(all_characters)
end

def get_films(character_hash)
  character_hash["films"].collect do |url|
    JSON.parse(RestClient.get(url))
  end
end

def get_character_movies_from_api(character)
  characters_page = get_characters("http://www.swapi.co/api/people/")
  while characters_page
    characters_page["results"].each do |character_hash|
      if character_hash["name"].downcase == character
        return get_films(character_hash)
      end
    end
    characters_page["next"] ? characters_page = get_characters(characters_page["next"]) : characters_page = nil
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

def return_list
  characters_page = get_characters("http://www.swapi.co/api/people/")
  x = []
  while characters_page
    y = characters_page["results"].collect do |character_hash|
      character_hash["name"].downcase
    end
    x << y
    characters_page["next"] ? characters_page = get_characters(characters_page["next"]) : characters_page = nil
  end
  x.flatten
end

def list
  puts return_list
end

def run()
  loop do
    character = get_character_from_user
    if character == 'list'
      list
    elsif character == 'exit'
      puts "Goodbye!"
      break
    elsif (return_list.include? character)
      show_character_movies(character)
    else
      puts "Invalid Character!"
    end
  end
end
