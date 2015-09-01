class ApiController < ApplicationController
  def all
    playlist = Playlist.all
    render json: {playlists: playlist}
  end

  def songs
    playlist = Playlist.find_by id: params[:id]
    songs = playlist.songs
    render json: {playlists: songs}
  end

  def vote
    this_track = Track.find(params[:song_ref])
    this_track.vote_count +=1
    this_track.save
  end


end