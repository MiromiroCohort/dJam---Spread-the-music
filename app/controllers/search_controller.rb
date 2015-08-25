class SearchController < ApplicationController

  def index
  end

  def new
  end

  def scrape
    query = params[:query]
    query_search = YoutubeScraper.search(query)
    flash.notice = "Scraping Youtube for first result matching: #{query}"
    redirect_to root_url
  end
end
