require 'pry'
class MusicLibraryController
  attr_accessor :path, :songs_sorted 
  
  def initialize (path="./db/mp3s")
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    until input == "exit"
      input = gets.strip
    end
  end
  
  def list_songs
    @songs_sorted = Song.all.sort_by {|s| s.name}
    songs_sorted.each_with_index do |song, index|
      index_plus_one = index + 1
      puts "#{index_plus_one}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists_sorted = Artist.all.sort_by {|a| a.name}
    artists_sorted.each_with_index do |artist, index|
      index_plus_one = index + 1
      puts "#{index_plus_one}. #{artist.name}"
    end
  end
  
  def list_genres
    sorted = Genre.all.sort_by {|g| g.name}
    sorted.each_with_index do |genre, index|
      index_plus_one = index + 1
      puts "#{index_plus_one}. #{genre.name}"
    end
  end
   
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input)
      a = Artist.find_by_name(input)
      sorted = a.songs.sort_by {|s| s.name}
      sorted.each_with_index do |song, index|
        index_plus_one = index + 1
        puts "#{index_plus_one}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input)
      g = Genre.find_by_name(input)
      sorted = g.songs.sort_by {|s| s.name}
      sorted.each_with_index do |song, index|
        index_plus_one = index + 1
        puts "#{index_plus_one}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i
    if input > 0 && input < Song.all.count
    index = input - 1
    song = @songs_sorted[index]
    binding.pry
      # puts "Playing #{song.name} by #{song.artist}"
    end
  end
    
end
  
  