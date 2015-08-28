class YoutubeScraper
  include HTTParty
  format :json

  base_uri "https://www.googleapis.com/youtube/v3"

  def self.search(query)
    modified_query = query.gsub(/\W/, "+")
    token = "AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y"
    response = self.get("/search?part=snippet&maxResults=5&q=#{modified_query}&type=video&videoDefinition=high&key=#{token}")
  end

  def self.scrape_duration(video_id)
    token = "AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y"
    response = self.get("/videos?part=contentDetails&id=#{video_id}&key=#{token}")
    duration_string = response["items"][0]["contentDetails"]["duration"]
  end


  def self.scrape_audio(video_id)
    link = "https://www.youtube.com/watch?v=#{video_id}"
    system("youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 #{link}")
  end

end

class ResultParser

  def initialize(json_string)
    @json_string = json_string
  end

  def parse_results
    song_array = []
    song_hashes = {}
    @json_string.each do |item|
      song_hash = {}
      song_hash["title"] =  item["snippet"]["title"]
      song_hash["image"] =  item["snippet"]["thumbnails"]["default"]["url"]
      song_hash["artist"] = "YouTube"
      key = item["id"]["videoId"]
      song_hashes[key] = song_hash
    end
    song_array << song_hashes
  end
end
