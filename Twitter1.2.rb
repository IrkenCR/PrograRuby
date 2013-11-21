require 'oauth'
require 'twitter'
require 'launchy'

def tweett(token_acceso,token_secreto) #Funcion que toma los valores secretos del usuario registrado
@cliente=Twitter::REST::Client.new do |config|
      config.consumer_key = 'x4pUZIkRRMRvCpVDJwdhw' #Codigo del usuario propietario de la aplicación
      config.consumer_secret = 'D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI' #Codigo secreto del usuario propietario de la aplicación.
      config.oauth_token = token_acceso
      config.oauth_token_secret = token_secreto
    end
    
puts "Publicar un nuevo Tweet..."
tweet= gets() #Obtenemos lo que el usuario digite
@cliente.update(tweet) #Funcion que envía el tweet
end
#puts "Estas siendo dirigido a la página de autenticación"
redirect_url = "http://ubuntulinuxcr.blogspot.com" #Dirige al usuario a la página de autenticación 
	
url = URI.parse(URI.encode(redirect_url.strip))
consumer_key='x4pUZIkRRMRvCpVDJwdhw'
consumer_secret='D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI'
consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
	                             { :site => "http://api.twitter.com" })
request_token = consumer.get_request_token#(:oauth_callback => url)
Launchy.open request_token.authorize_url
puts "Por favor ingrese el PIN que le fue dado cuando autorizo la aplicacion"
pincode = gets.chomp #Se toma el PIN ingresado por el usuario el cual permite interactuar con su perfil de twitter
access_token = request_token.get_access_token :oauth_verifier => pincode #Verificación del código de PIN
puts access=access_token.token # user token
puts secret=access_token.secret # user oauth secret
tweett(access,secret) #Hace llamado a la función tweett con los datos del usuario que autorizo la aplicación

# 3 es 4, precio = image, dire = precio, precio = dire, ABAJO i5 = image, precio = i4
#dire = i3, 
