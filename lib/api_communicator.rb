require 'rest-client'
require 'json'
require 'pry'

def capitalize_character(character)
  # puts "#{character}"
  # char_lowercase =  character.downcase

  char_array=  character.split(" ")
  capitalized = []
  char_array.each {|word| capitalized << word.capitalize }#capitalize.join(" ")
  # puts "#{capitalized.join(" ")}"
  capitalized.join(" ")
end

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')

  # binding.pry
  # puts "#{character_hash}

#first find the character in the hash
#if not in first page keep useing character_hash["next"]
  character_found = false
  hit_api = true
  # count = 0
  page=0
  character=capitalize_character(character)
  while hit_api do
    page +=1
    url = 'http://www.swapi.co/api/people/?page='+page.to_s
    all_characters = RestClient.get(url)
    character_hash = JSON.parse(all_characters)
    found_character_hash = nil

    character_hash["results"].each do |person|
      if person["name"]==character
        # puts "FOUND #{character}"
        character_found=true
        hit_api=false
        found_character_hash = person
      end #if
    end #end do

    hit_api=false if page == 9

  end #while hit_api
  # puts "**********found on page #{page}"


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  movie_urls = []
  if character_found
    # puts "#{found_character_hash}"
    # puts found_character_hash["films"]
    found_character_hash["films"].each  {|film| movie_urls << film}
  end #if character_found
  # puts "******#{movie_urls}"

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
    #collected in movie_urls
  movie_urls_info = []
  movie_urls.each do |movie|
    info=RestClient.get(movie)
    info_hash = JSON.parse(info)
    movie_urls_info << info_hash
    # all_characters = RestClient.get(url)
    # character_hash = JSON.parse(all_characters)
  end #movie_urls.each
  # puts "*****#{movie_urls_info}"
  puts "Character #{character} not found" if character_found == false
  movie_urls_info
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # puts films_hash
  # puts "Inside method"
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# binding.pry
# get_character_movies_from_api("Luke Skywalker")
# get_character_movies_from_api("Tion Medon")
  # parse_character_movies(get_character_movies_from_api("Luke Skywalker"))
  # parse_character_movies(get_character_movies_from_api("Tion Medon"))
  # parse_character_movies(get_character_movies_from_api("tion medon"))
# puts "end api"
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
