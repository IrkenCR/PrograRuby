require "rubygems"
require 'sinatra'
require 'slim'

set:port,3232
 
post '/' do
  @task =  params[:task]
  slim :task
end
