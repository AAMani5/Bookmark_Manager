ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './app/data_mapper_setup'

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
    tag = Tag.first_or_create(name: params[:tags]) # first_or_create so that it doesn't create a new one if one already exists
    LinkTag.create(:link => link, :tag => tag ) # creates the necessary relation between the two(link.tags << tag & link.save)
    redirect '/links'
  end

  get '/tags/bubbles' do
    @links = Link.all.select{|link| link.tags.map(&:name).include?('bubbles')}
    erb :'links/bubbles'
  end

  run if app_file == $0
end
