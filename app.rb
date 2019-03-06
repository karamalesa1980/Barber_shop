#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	@db.execute('SELECT * FROM barber WHERE name=?', [name]).length > 0
end	

def seed_db db, barbers
  barbers.each do |barber|
    if !is_barber_exists? @db, barber
      @db.execute 'INSERT INTO barber (name) VALUES (?)', [barber]
    end
  end
end

def get_db
   @db =  SQLite3::Database.new 'test.sqlite3'
   @db.results_as_hash = true
  return @db
end

configure do
	@db = get_db
	@db.execute 'CREATE TABLE IF NOT EXISTS
	"visit"
	  (
		"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
		"name"	TEXT,
		"phone"	TEXT,
		"date"	TEXT,
		"barber"TEXT,
		"color"	TEXT
	  )';
	  @db.execute 'CREATE TABLE IF NOT EXISTS
	"users"
	  (
		"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
		"email"	TEXT,
		"body"	TEXT
		
	  )';
	  @db.execute 'CREATE TABLE IF NOT EXISTS "barber"
	    (
	      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
	      "name" TEXT
    )';

     seed_db @db, ['Foo', 'Faa', 'Moo', 'Zoo', 'Faz', 'Maz', 'Kraz']

  	 @db.close  
end	



get '/' do

	 get_db
     @options = @db.execute 'SELECT * FROM barber'
     @db.close

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

get '/showusers' do
	@db = get_db

    @results = @db.execute 'SELECT * FROM visit ORDER BY id DESC'
    @db.close
	erb :showusers
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
	
		
	
    save_form_data_to_database
	
	
	if @error != ""
		return erb :visit
	end

	erb "<h4>Спасибо #{@user_name} вы записались, будем ждать вас #{@date_time}</h4>"
		
end




post '/contacts' do 

	@user_email = params[:user_email]
	@user_body = params[:user_body]

	@db = get_db

	@db.execute "insert into users(email, body) values('#{@user_email}', '#{@user_body}')"

	@db.close



	erb "<h4>Спасибо ваше сообщение отправлено!</h4>"


end



def save_form_data_to_database
  @db = get_db
  @db.execute 'INSERT INTO visit (name, phone, date, barber, color)
  VALUES (?, ?, ?, ?, ?)', [@user_name, @user_phone, @date_time, @professional, @color]
  @db.close
end
