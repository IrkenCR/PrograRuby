require 'sinatra'
require 'rubygems'
require 'slim'
require 'nokogiri'
require 'open-uri'
require 'oauth'
#require 'twitter'
#require 'launchy'

set :port, 9495


def coco()
    page = Nokogiri::HTML(open("http://en.wikipedia.org/"))
    puts page.class # => Nokogiri::HTML::Document
    puts page.css('title')
end



def coco2()
    wxe = Nokogiri::HTML(open("http://bandcamp.com/search?q=trova&from=corphome"))
    puts wxe.css('title')
end


def coco3(aaa)
    wxe = Nokogiri::HTML(open("http://bandcamp.com/tag/"+aaa))
    cont = 0
    news_links = wxe.css('li[class="item"]') #busca los resultados
    datos = wxe.css('img[class="art"]') #extrae las imagenes
    var1 = news_links.css("div[class='itemtext']")
    var2 = news_links.css("div[class='itemsubtext']")
    resultado = [10]
    while(cont<10)
        
        news_links2 = news_links.css('a')[cont]['href'] #link del artista
        
        news_links3 = var2.css('div')[cont].text
        
        news_links4 = var1.css('div')[cont].text
        
        news_links5 = datos.css('img')[cont]['src']
        
        news_links1 = gratuita(news_links2)
        
        resultado[cont] = [news_links3,news_links4,news_links1,news_links5,news_links2]
        
        puts "----------------------------"+(cont+1).to_s+"--------------------------------"
        puts "Direccion: " + news_links2
        puts "Artista: " + news_links3
        puts "Album: " + news_links4
        puts "Imagen: " + news_links5
        puts "Precio: " + news_links1
        cont = cont + 1
    end
    return resultado
    
end


def gratuita(url)
    wxe = Nokogiri::HTML(open(url))
    news_links = wxe.css('li[class="buyItem"]') #busca los resultados
    z = news_links.length
    if(news_links.length==1)
        begin
            return news_links.css('span')[1].text + " " + news_links.css('span')[2].text
            rescue Exception=>e
            return "Put price"
        end
    end
    if(news_links.length==0)
        return "Gratuito"
        else
        return gratuitaaux(news_links)
    end
end

def gratuitaaux(news_links)
    var1 = news_links.css("span[class='buyItemPackageTitle primaryText']")
    var2 = news_links.css("span[class='base-text-color']")
    var3 = news_links.css("span[class='buyItemExtra secondaryText']")
    var4 = news_links.css("span[class='buyItemExtra buyItemNyp secondaryText']")
    x = news_links.length
    cont = 0
    res = ""
    xxx = 1
    if(var4.length>0)
        res = res + xxx.to_s() + ". " + var1.css('span')[cont].text + " = beat minimium" + var4.css('span')[cont].text + "\n" + "\t"+ "   "
        xxx = xxx + 1
        while(x>cont+1)
            res = res + xxx.to_s() +". "  + var1.css('span')[cont+1].text+ "=" + var2.css('span')[cont].text +  var3.css('span')[cont].text + "\n" + "\t" + "   "
            cont = cont + 1
            xxx = xxx + 1
        end
        else
        while(x>cont)
            res = res + xxx.to_s() + ". " + var1.css('span')[cont].text+ "=" + var2.css('span')[cont].text  + var3.css('span')[cont].text + "\n" + "\t" + "   "
            cont = cont + 1
            xxx = xxx + 1
        end
    end
    return res
end

def tweett(token_acceso,token_secreto) #Funcion que toma los valores secretos del usuario registrado
@user=Twitter::REST::Client.new do |config|
      config.consumer_key = 'x4pUZIkRRMRvCpVDJwdhw' #Codigo del usuario propietario de la aplicación
      config.consumer_secret = 'D8yU5s5qzRHfnfSN6pZXXZEobqfn2dqGZ27HlwwOiI' #Codigo secreto del usuario propietario de la aplicación.
      config.oauth_token = token_acceso #Token de acceso del usuario
      config.oauth_token_secret = token_secreto #Token de acceso secreto del usuario (contraseña)
    end

puts "Publicar un nuevo Tweet..."
tweet= gets() #Obtenemos lo que el usuario digite
@user.update(tweet) #Funcion que envía el tweet
end

def publicareltweet()
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
end




get '/' do
    slim :index
end

post "/buscando" do
    txt=params[:elemento]
    @@arreglo = coco3(txt)
    subArreglo = @@arreglo[0]
    @@a1 = subArreglo[0]
    @@a2 = subArreglo[1]
    @@a3 = subArreglo[2]
    @@a4 = subArreglo[3]
    @@a5 = subArreglo[4]
    
    subArreglo = @@arreglo[1]
    @@b1 = subArreglo[0]
    @@b2 = subArreglo[1]
    @@b3 = subArreglo[2]
    @@b4 = subArreglo[3]
    @@b5 = subArreglo[4]
    
    subArreglo = @@arreglo[2]
    @@c1 = subArreglo[0]
    @@c2 = subArreglo[1]
    @@c3 = subArreglo[2]
    @@c4 = subArreglo[3]
    @@c5 = subArreglo[4]
    
    subArreglo = @@arreglo[3]
    @@d1 = subArreglo[0]
    @@d2 = subArreglo[1]
    @@d3 = subArreglo[2]
    @@d4 = subArreglo[3]
    @@d5 = subArreglo[4]
    
    subArreglo = @@arreglo[4]
    @@e1 = subArreglo[0]
    @@e2 = subArreglo[1]
    @@e3 = subArreglo[2]
    @@e4 = subArreglo[3]
    @@e5 = subArreglo[4]
    
    subArreglo = @@arreglo[5]
    @@f1 = subArreglo[0]
    @@f2 = subArreglo[1]
    @@f3 = subArreglo[2]
    @@f4 = subArreglo[3]
    @@f5 = subArreglo[4]
    
    subArreglo = @@arreglo[6]
    @@g1 = subArreglo[0]
    @@g2 = subArreglo[1]
    @@g3 = subArreglo[2]
    @@g4 = subArreglo[3]
    @@g5 = subArreglo[4]
    
    subArreglo = @@arreglo[7]
    @@h1 = subArreglo[0]
    @@h2 = subArreglo[1]
    @@h3 = subArreglo[2]
    @@h4 = subArreglo[3]
    @@h5 = subArreglo[4]
    
    subArreglo = @@arreglo[8]
    @@i1 = subArreglo[0]
    @@i2 = subArreglo[1]
    @@i3 = subArreglo[2]
    @@i4 = subArreglo[3]
    @@i5 = subArreglo[4]
    
    subArreglo = @@arreglo[9]
    @@j1 = subArreglo[0]
    @@j2 = subArreglo[1]
    @@j3 = subArreglo[2]
    @@j4 = subArreglo[3]
    @@j5 = subArreglo[4]
    
    
    redirect '/resultados'
    
end

get '/resultados' do
    erb :hello_form, :locals => {   :a1 => @@a1,:a2 =>@@a2,:a3 => @@a3,:a4 => @@a4,:a5 => @@a5,
                                    :b1 => @@b1,:b2 =>@@b2,:b3 => @@b3,:b4 => @@b4,:b5 => @@b5,
                                    :c1 => @@c1,:c2 =>@@c2,:c3 => @@c3,:c4 => @@c4,:c5 => @@c5,
                                    :d1 => @@d1,:d2 =>@@d2,:d3 => @@d3,:d4 => @@d4,:d5 => @@d5,
                                    :e1 => @@e1,:e2 =>@@e2,:e3 => @@e3,:e4 => @@e4,:e5 => @@e5,
                                    :f1 => @@f1,:f2 =>@@f2,:f3 => @@f3,:f4 => @@f4,:f5 => @@f5,
                                    :g1 => @@g1,:g2 =>@@g2,:g3 => @@g3,:g4 => @@g4,:g5 => @@g5,
                                    :h1 => @@h1,:h2 =>@@h2,:h3 => @@h3,:h4 => @@h4,:h5 => @@h5,
                                    :i1 => @@i1,:i2 =>@@i2,:i3 => @@i3,:i4 => @@i4,:i5 => @@i5,
                                    :j1 => @@j1,:j2 =>@@j2,:j3 => @@j3,:j4 => @@j4,:j5 => @@j5}
end         


#Corrida de busqueda
#coco3("rock")



#Diseño de la pagina





