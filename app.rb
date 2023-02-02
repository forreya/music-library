
require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"
    @io.puts ""
    @io.puts "1 - List all albums"
    @io.puts "2 - List all artists"
    choice = @io.gets.chomp

    if choice == '1'
      display_albums
    elsif choice == '2'
      display_artists
    else
      @io.puts "Please choose 1 or 2."
      app.run
    end
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  def display_artists
    @io.puts ""
    @io.puts "Here is the list of artists:"
    @artist_repository.all.each{
      |artist|
      puts "#{artist.id} - #{artist.name}"
    }
  end

  def display_albums
    @io.puts ""
    @io.puts "Here is the list of albums:"
    @album_repository.all.each{
      |album|
      puts "#{album.id} - #{album.title}"
    }
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end