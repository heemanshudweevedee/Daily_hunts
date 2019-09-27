class NewsController < ApplicationController
  before_action :fetch_news, only: [:index]

  def index
    # placeholder for images that do not exist
    @image_placeholder = 'https://placehold.it/50x50'
    @articles ||= []
    if current_user 
      @bookmark = current_user.bookmarks.new
    end
  end

  def search
    @image_placeholder = 'https://placehold.it/50x50'
    query = params[:q]
    @articles = fetch_news_query query unless !query
    @articles ||= [] # empty array if no query

    if current_user 
      @bookmark = current_user.bookmarks.new
    end
  end

  private

  def fetch_news_query query
    url = "https://newsapi.org/v2/everything?q=#{query}&apiKey=522dcc5247dc4f51ad23eb172f8d5808&language=en"
    response = HTTParty.get url
    response.parsed_response['articles'] unless response.code != 200
  end

end