require "rubygems"
require 'twitter'
#require 'sinatra' #Se utilizó Sinatra para poder correr la aplicación utilizando un localhost, para así probar que esta funcione de la manera correcta.
class Tweet
	puts "Publicar un nuevo Tweet..."
	tweet= gets() #Obtenemos lo que el usuario digite
	def initialize (tweet)
		puts "Publicar un nuevo Tweet..."
		tweet= gets() #Obtenemos lo que el usuario digite
		Twitter.configure do |config|
				config.consumer_key = 'x4pUZIkRRMRvCpVDJwdhw'
   				config.consumer_secret = 'D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI'
				config.oauth_token = '948173238-0rDoOacK40XT7HmdmtGZXPvghX2pq7xhjjjer8pw'
				config.oauth_token_secret = 'fhsZZQAxoFmUqcFUbnUWJl5TmCU45tSJj6yrOv9rJYb1J'
		end
		Twitter.update(tweet)
		end
#end
#Twitter.configure do |config|
#			config.consumer_key = 'x4pUZIkRRMRvCpVDJwdhw'
#			config.consumer_secret =  'D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI'
end
