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

    render json: {songs: new_results}
  end

  def add
    query = params[:query]
    song_detail = YoutubeScraper.add_song(query)
    p song_detail
    # render json: {song: query}
  end


end

