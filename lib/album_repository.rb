require_relative 'album'

class AlbumRepository
  def all
    sql = "SELECT id, title, release_year, artist_id FROM albums;"
    result_set = DatabaseConnection.exec_params(sql,[])

    albums = []
    
    result_set.each{
      |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums.push(album)
    }

    albums
  end

  def find(id)
    sql = "SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;"
    result_set = DatabaseConnection.exec_params(sql,[id])[0]

    album = Album.new
    album.id = result_set['id']
    album.title = result_set['title']
    album.release_year = result_set['release_year']
    album.artist_id = result_set['artist_id']
    
    album
  end

  def create(new_album)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES($1,$2,$3);"
    title = new_album.title
    release_year = new_album.release_year
    artist_id = new_album.artist_id

    result_set = DatabaseConnection.exec_params(sql,[title, release_year, artist_id])
  end
end