ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './app/data_mapper_setup'

class BookmarkManager < Sinatra::Base

  # use Rack::Session::Pool, :expire_after => 2592000
  enable :sessions
  set :session_secret, 'secret'

  helpers do
    def current_user
      @current_user ||= User.first(:id => session[:user_id])
    end
  end

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
    link = Link.first_or_create(url: params[:url], title: params[:title])
    tag_names = params[:tags].split
    tag_names.each do |tag_name|
      tag = Tag.first_or_create(name: tag_name.downcase ) # first_or_create so that it doesn't create a new one if one already exists
      LinkTag.first_or_create(:link => link, :tag => tag ) # creates the necessary relation between the two(link.tags << tag & link.save)
    end
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(:name => params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/users' do
    user = User.create(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/users/new' do
    erb :'links/signup'
  end

  run if app_file == $0
end
