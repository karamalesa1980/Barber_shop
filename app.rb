#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


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

				# вернуть представление visit
			erb :visit
			
				

		end
				
	end
		
	
	@title = 'Спасибо!'
	@message = "#{@user_name} мы будем вас ждать!  #{@date_time} "

	f = File.open './public/users.txt', 'a'
	f.write "User: #{@user_name}, Phone: #{@user_phone}, Date and time: #{@date_time}, Professional: #{@professional}, Color: #{@color}\n"
	f.close
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
