ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require './app/models/link'
require './app/models/tag'

class BookmarkManager < Sinatra::Base


  get '/' do
    "Hello World" # infrastructure set-up check
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag = Tag.create(name: params[:tags])
    LinkTag.create(:link => link, :tag => tag )
    redirect '/links'
  end

  run if app_file == $0
end
