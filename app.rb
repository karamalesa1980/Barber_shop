#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'test.sqlite3'
	@db.execute 'CREATE TABLE IF NOT EXISTS
	"visit"
	  (
		`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
		`name`	TEXT,
		`phone`	TEXT,
		`date`	TEXT,
		`barber`TEXT,
		`color`	TEXT
	  )'
end	

get '/' do
	erb "Hello! <a href=\"https://github.com/karamalesa1980\">My GitHub</a> pattern has been modified for <a href=\"https://www.youtube.com/channel/UCiqUSuswB1_uU2BONwvCTYg?view_as=subscriber\">Karamalesa TV</a>"			
end

get '/contacts' do
	erb :contacts
end	

get '/about' do
	@error = 'Error 404 - Страница в разроботке!'
	erb :about
end	

get '/something' do
	@error = 'Error 404 - Страница в разроботке!'
	erb :something
end	

get '/visit' do

	erb :visit
end	

post '/visit' do
	@user_name   = params[:user_name]
	@user_phone  = params[:user_phone]
	@date_time   = params[:date_time]
	@professional = params[:professional]
	@color = params[:colorpicker]



	# хеш 

	hh = { :user_name => "Введите Ваше имя",
		   :user_phone => "Введите Ваш телефон",
		   :date_time => "Введите дату и время"
		    
	}

	@error = hh.select {|key,_| params[key] == ""}.values.join(",  ")
	
		
	
    @db = SQLite3::Database.new 'test.sqlite3'
	@db.execute "insert into visit(name, phone, date, barber, color) values('#{@user_name}', '#{@user_phone}', '#{@date_time}', '#{@professional}', '#{@color}')"

	@db.close
	
	if @error != ""
		return erb :visit
	end

	erb "<h4>Спосибо #{@user_name} вы подписались, будем ждать вас #{@date_time}</h4>"
	

	
		
		
	



	
end
post '/contacts' do 

	@user_email = params[:user_email]
	@user_body = params[:user_body]

	db = SQLite3::Database.new 'test.sqlite3'

	db.execute "insert into users(email, body) values('#{@user_email}', '#{@user_body}')"

	db.close



	erb :contacts


end
