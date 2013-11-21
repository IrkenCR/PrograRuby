require "rubygems"
require 'twitter'
require 'open-uri'
require 'hpricot'
require 'twitter_oauth'
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
end
def login() #Metodo que se encarga de loguear al usuario en la cuenta, con ayuda de la libreria oauth
        @cliente = TwitterOAuth::Client.new(:consumer_key => 'x4pUZIkRRMRvCpVDJwdhw',
        :consumer_secret => 'D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI')
        

        request_token = @cliente.request_token
        #La idea aqui es como el boton abrir el enlace de una vez
        puts ("Favor autorizar la aplicacion. Para hacerlo presione click derecho sobre el siguiente link")
        puts ("Luego click izquierdo en" "abrir el enlace" "\n")
        puts request_token.authorize_url
        puts ("\nPresione Enter para continuar, luego de permitir el acceso")
        STDIN.gets

        begin        
                access_token = @cliente.authorize(
                  request_token.token,
                  request_token.secret)
                rescue Exception => e
                        abort("No se ha aceptado la conexion de la aplicacion, programa cerrando...")
                puts ("Conexion establecida satisfactoriamente")
                @cliente.update(tweet)
        end
                
        rescue Exception => e
                abort( "TIMEOUT EXCEPTION: al parecer hay un problema con la conexion a internet, programa cerrando...")
end 
begin 
login()
end

