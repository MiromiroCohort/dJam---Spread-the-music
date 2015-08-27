require 'pp'
class SearchController < ApplicationController

  def index
  end

  def new
  end

  def scrape
    query = params[:query]
    query_search = YoutubeScraper.search(query)
    flash.notice = "Scraping Youtube for first result matching: #{query}"
    five_songs_array = query_search["items"]
    results = ResultParser.new(five_songs_array)
    new_results = results.parse_results
    # counter = 0
    # for result in new_results[0] do
    #   p result[1]["title"]
    # end
    render json: {songs: new_results}
  end

  def add
    video_id = params[:video_id]
    song_duration = YoutubeScraper.scrape_duration(video_id)
    p "Song duration: #{song_duration}"
    t = song_duration.match(/PT([0-9]+H)?([0-9]+M)?([0-9]+S)?/)
    length = 0
    length += (t[1].to_i * 60) * 60
    length += t[2].to_i * 60
    length += t[3].to_i
    # new_track = Track.create(artist: params[:artist], title: params[:title], length: length)
    render json: {song: new_track}
  end
end

