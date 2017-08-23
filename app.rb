require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

require_relative 'models/contact'
also_reload 'models/contact'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  @contacts = Contact.all
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end

post '/newcontact' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  phone_number = params[:phone_number].gsub(/[\(\)\-]+/, '')

  Contact.create(first_name: first_name, last_name: last_name, phone_number: phone_number)

  redirect '/'
end
