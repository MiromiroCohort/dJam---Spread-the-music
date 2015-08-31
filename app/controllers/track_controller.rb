require 'mp3info'
require 'net/ssh'
require 'net/scp'


class TrackController < ApplicationController

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
    video_id = params[:video_id]
    title = params[:title]
    artist = params[:artist]
    song_duration = YoutubeScraper.scrape_duration(video_id)
    t = song_duration.match(/PT([0-9]+H)?([0-9]+M)?([0-9]+S)?/)
    length = 0
    length += (t[1].to_i * 60) * 60
    length += t[2].to_i * 60
    length += t[3].to_i
    p "Song length: #{length}"
    song_download = YoutubeScraper.scrape_audio(video_id)
    mp3_tagger(artist, title, video_id, length)
    redirect_to '/index'
  end

  def mp3_tagger(artist, title, video_id, length)
    path_name = (Dir.glob("#{Rails.root}/*#{video_id}.mp3")[0])
    p path_name
    Mp3Info.open(path_name) do |mp3|
      mp3.tag.artist = artist
      mp3.tag.title = title
      mp3.tag.length = length
      p mp3
    end
    transfer_to_client_dir(path_name)
  end

  def transfer_to_client_dir(file_path_and_name)
    Net::SCP.upload!("192.168.1.34", "djam", file_path_and_name,  "/media/mpd_music", :ssh => { :password => "C#ristmas25" })
    File.delete(file_path_and_name)
  end

end
