# require 'httparty'
require 'json'

class YoutubeScraper
  include HTTParty

  # # base_uri https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{query}&type=video&videoCategoryId=music&key=AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y
  # AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y

  # base_uri "https://www.googleapis.com/youtube/v3"s

  def self.scrape_audio(video_id)
    p video_id
  end

  def self.search(query)
    modified_query = query.gsub(/\W/, "+")
    token = "AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y"
    response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{modified_query}&type=video&videoCategoryId=music&videoDefinition=high&key=#{token}")
    video_id = response["items"][0]["id"]["videoId"]
    YoutubeScraper.scrape_audio(video_id)
  end


end
