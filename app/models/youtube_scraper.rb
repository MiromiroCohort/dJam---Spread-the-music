class YoutubeScraper
  include HTTParty

  base_uri "https://www.googleapis.com/youtube/v3"



  def self.search(query)
    modified_query = query.gsub(/\W/, "+")
    token = "AIzaSyBAKGAA_wIMXH_lANamrJ1CScHyRLjmX3Y"
    response = self.get("/search?part=snippet&maxResults=5&q=#{modified_query}&type=video&videoCategoryId=music&videoDefinition=high&key=#{token}")
    video_id = response["items"]
    puts video_id
    # YoutubeScraper.scrape_audio(video_id)
  end


  def self.scrape_audio(video_id)
    link = "https://www.youtube.com/watch?v=#{video_id}"
    system("youtube-dl --extract-audio --audio-format mp3  --audio-quality  0 #{link}")
  end

end
