ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './app/data_mapper_setup'

class BookmarkManager < Sinatra::Base


  get '/' do
    "Hello World" # infrastructure set-up check
  end

  get '/links' do
    @links = Link.all
    @user = User.first
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag_names = params[:tags].split
    tag_names.each do |tag_name|
      tag = Tag.first_or_create(name: tag_name ) # first_or_create so that it doesn't create a new one if one already exists
      LinkTag.first_or_create(:link => link, :tag => tag ) # creates the necessary relation between the two(link.tags << tag & link.save)
    end
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(:name => params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/signup' do
    User.first_or_create(:email => params[:email], :password => params[:password])
    redirect '/links'
  end

  get '/signup' do
    erb :'links/signup'
  end

  run if app_file == $0
end
