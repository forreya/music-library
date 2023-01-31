
require 'album_repository.rb'

describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('seeds/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end
  
  it 'returns an array of all albums' do
    repo = AlbumRepository.new
    albums = repo.all 

    expect(albums.length).to eq 2
    expect(albums.first.id).to eq '1'
    expect(albums.first.title).to eq 'DMZ'
  end

  it 'returns an album based on a given id' do
    repo = AlbumRepository.new
    album = repo.find(1)

    expect(album.id).to eq '1'
    expect(album.title).to eq 'DMZ'
    expect(album.release_year).to eq '2019'
    expect(album.artist_id).to eq '1'
  end

  it 'creates a new Album object and adds it to the albums table' do
    repo = AlbumRepository.new
    album = Album.new

    album.title = "A Love Letter To You 4"
    album.release_year = "2019"
    album.artist_id = "3"

    repo.create(album)
    all_albums = repo.all

    expect(all_albums.last.title).to eq "A Love Letter To You 4"
    expect(all_albums.last.release_year).to eq '2019'
    expect(all_albums.last.artist_id).to eq '3'
  end

end