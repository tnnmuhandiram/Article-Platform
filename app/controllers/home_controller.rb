class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token


  def index
    @articles = Article.order("RAND()").limit(10) 
  end

  #rendering import type form components 
  def select_type
    if params[:type] == "2"
      render :partial => '/components/import_type/everything', :formats => [:html]
    elsif params[:type] == "3"
      render :partial => '/components/import_type/source', :formats => [:html]
    else
      render :partial => '/components/import_type/top_headline', :formats => [:html]
    end
  end

  #Getting sources data from News API 
  def import_sources
    
    require 'open-uri'
    url = 'https://newsapi.org/v2/sources?'\
          'language=en&country=us&'\
          "apiKey=#{Figaro.env.NEWS_API_KEY}"
    req = open(url)
    response_body = req.read

    

    params["data"].each do |data|
      data["facebook_id"] = data["id"]
      SomeRecordClass.create(data)
    end

    # puts response_body
    # sources = newsapi.get_sources(country: 'us', language: 'en')
    redirect_to "/"
  end 

  def import_everything
    
    from = params['from']
    to = params['to']
    key = params['key']
    sortBy = params['everything'][1]

    require 'open-uri'
    url = "https://newsapi.org/v2/everything?"\
      "q=#{key}&from=#{ DateTime.parse(from).strftime("%Y-%m-%d")}&sortBy=#{sortBy}&apiKey=#{Figaro.env.NEWS_API_KEY}"
    req = open(url)
    response = req.read
    require 'digest/sha1'
    
    #Insert Data to Database 
    ActiveSupport::JSON.decode(response)['articles'].each do |data|
      uuid = Digest::SHA1.hexdigest("#{data['source']['name']}#{data['source']['id']}#{data['publishedAt']}")
      exist_article = Article.where("uuid = ?", uuid).first
      if exist_article.nil?
        article = Article.new()
        article.uuid = uuid
        article.source_id = data['id']
        article.source_name = data['name']
        article.author = data['author']
        article.title = data['title']
        article.description = data['description']
        article.url = data['url']
        article.urlToImage = data['urlToImage']
        article.publishedAt = data['publishedAt']
        article.content = data['content']
        article.save
      end
    end
    redirect_to "/"
  end

  def import_headline

    key = params['key']
    category = params['anything'][0]
    country = params['anything'][1]

    require 'open-uri'
    url = "https://newsapi.org/v2/top-headlines?"\
      "country=#{country}&category=#{category }&q=#{key}&apiKey=#{Figaro.env.NEWS_API_KEY}"
    req = open(url)
    response = req.read
    require 'digest/sha1'

    #Insert Data to Database 
    ActiveSupport::JSON.decode(response)['articles'].each do |data|
      uuid = Digest::SHA1.hexdigest("#{data['source']['name']}#{data['source']['id']}#{data['publishedAt']}")
      exist_article = Article.where("uuid = ?", uuid).first
      if exist_article.nil?
        article = Article.new()
        article.uuid = uuid
        article.source_id = data['id']
        article.source_name = data['name']
        article.author = data['author']
        article.title = data['title']
        article.description = data['description']
        article.url = data['url']
        article.urlToImage = data['urlToImage']
        article.publishedAt = data['publishedAt']
        article.content = data['content']
        article.save
      end
    end
    redirect_to '/'
  end

end
