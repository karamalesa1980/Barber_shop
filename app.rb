#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	db = SQLite3::Database.new 'test.sqlite3'
	db.execute 'CREATE TABLE IF NOT EXISTS
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

	
	# для каждой пары ключ-значение
	hh.each do |key, value|

		# если параметр пуст
		if params[key] == ''

				# переменной error присвоить value из хеша hh
				# (а value из хеша hh это сообщение об ошибке)
				# т.е переменной error присвоить сообщение об ошибке
			@error = hh[key]

		    #@title = 'Спасибо за запись'
		    #@message = "#{@user_name}, мы будем вас ждать!  #{@date_time} "
		
				# вернуть представление visit
		end

	end
	
	
		
	
    db = SQLite3::Database.new 'test.sqlite3'
	db.execute "insert into visit(name, phone, date, barber, color) values('#{@user_name}', '#{@user_phone}', '#{@date_time}', '#{@professional}', '#{@color}')"

	db.close
	
	erb :visit
	

	
		
		
	



	
end
post '/contacts' do 

	@user_email = params[:user_email]
	@user_body = params[:user_body]

	db = SQLite3::Database.new 'test.sqlite3'

	db.execute "insert into users(email, body) values('#{@user_email}', '#{@user_body}')"

	db.close



	erb :contacts


end
