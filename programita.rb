require 'sinatra'
require 'rubygems'
require 'slim'
require 'nokogiri'
require 'open-uri'
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
	while(cont<3)
	
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
    if(var4.length>0)
        res = res + var1.css('span')[cont].text + var4.css('span')[cont].text + "\n" + "\t"
        while(x>cont+1)
            res = res + var1.css('span')[cont+1].text + var2.css('span')[cont].text + var3.css('span')[cont].text + "\n" + "\t"
            cont = cont + 1
        end
        else
        while(x>cont)
            res = res + var1.css('span')[cont].text + var2.css('span')[cont].text + var3.css('span')[cont].text + "\n" + "\t"
            cont = cont + 1
        end
    end
    return res
end




get '/' do
    slim :index
end

post "/buscando" do
	erb :fail
end

post "/buscando3" do
    txt=params[:elemento]
    coco3(txt)
    "Busqueda satisfactoria para:#{params[:elemento]}"

end

post '/breakfast' do
	
	
    breakfast = {}
    
    breakfast[:x] = 1
    breakfast[:artista] = "Mike Rudelbar"
    breakfast[:album] = "Stars giving milk"
    breakfast[:direccion] = "http://bandcamp.com/tag/rock"
    breakfast[:precio] = "10 US"

    erb :breakfast, :locals => {:breakfast => breakfast}
end

#Diseño de la pagina
__END__
@@layout
<!DOCTYPE html>
<html>
<body>

<center>
<h1>Chiqui chiqui
<p>
<img border="10" img src="http://i1.ytimg.com/vi/svBonkNlmAY/hqdefault.jpg" alt="chiqui chiqui" width="400" height="350">

<p>

<form action="/buscando" method="post">
<input type="text" name="elemento" size="40" ><br>
<input type="submit" value="Buscar">
</form>

</body>
</html>

