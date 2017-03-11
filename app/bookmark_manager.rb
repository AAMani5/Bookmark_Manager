ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require './app/data_mapper_setup'

class BookmarkManager < Sinatra::Base

  # use Rack::Session::Pool, :expire_after => 2592000
  enable :sessions, :method_override
  set :session_secret, 'secret'
  register Sinatra::Flash

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
    @user = User.create(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
    if @user.valid?
      session[:user_id] = @user.id
      redirect '/links'
    else
      @user.errors.each{|e| flash.now[:message] = e.first} # = "Password and confirmation password do not match"
      erb :'links/signup'
    end
  end

  get '/users/new' do
    @user = User.new  # nil for new user & when redirected, gets value from @user in /users
    erb :'links/signup'
  end

  get '/session/new' do
    erb :'links/signin'
  end

  post '/session' do
    user = User.authenticate(params[:email], params[:password])
     if user
       session[:user_id] = user.id
       redirect to('/links')
     else
       flash[:message] = 'The email or password is incorrect'
       redirect 'session/new'
     end
  end

  delete '/session' do
    session[:user_id] = nil
    flash[:message] = 'goodbye!'
    redirect '/links'
  end

  run if app_file == $0
end
