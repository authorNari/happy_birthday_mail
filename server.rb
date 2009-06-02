$: << File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'models/friends'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end
 
get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end
 
get '/' do
  redirect '/friends'
end
 
get '/friends' do
  @friends = Friends.order_by(:created_at.desc)

  haml :index
end

post '/friends' do
  Friends.create(params[:friend].merge(:created_at => Time.now))
 
  redirect '/'
end

get '/friends/edit/:id' do
  @friend = Friends[:id => params[:id]]

  haml :edit
end

put '/friends/:id' do
  Friends[:id => params[:id]].update(params[:friend].merge(:updated_at => Time.now))
 
  redirect '/'
end

delete '/friends/:id' do
  Friends.where(:id => params[:id]).destroy
 
  redirect '/'
end
