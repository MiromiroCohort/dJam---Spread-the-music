class ApiController < ApplicationController
  def all
    playlist_array = []
    Track.each { |item| playlist_array << item }
    render json: {playlists: playlist_array}
  end

  def songs
    playlist = Playing.find_by id: params[:id]
    songs = playlist.songs
    render json: {playlists: songs}
  end

  def vote
    this_track = Track.find(params[:song_ref])
    this_track.vote_count +=1
    this_track.save
  end
end