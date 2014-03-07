class Connection
  require 'rails/all'
  require 'active_record'
  require 'digest/sha1'
 
  def initialize(*args)
    puts 'args : #{args}'
    
    args.each |arg| do
      puts arg[:adapter]
      if arg[:adapter] == 'mysql2'
        require 'mysql2'
      elsif arg[:adapter == 'pg']
        require 'pg' 
      elsif arg[:adapter] == 'sqlite3'
        require 'sqlite3'  
      end
      
      adapter = arg[:adapter]
      db_name = arg[:db_name]
      db_user = arg[:db_user]
      db_pass = arg[:db_pass]
      username = arg[:username]
      password = arg[:password]
    end
  end
   
  def setup
    if (adapter && db_name && db_user && username && password)
      connection = ActiveRecord::Base.establish_connection(
                    adapter:  adapter,
                    host:     'localhost',
                    database: db_name,
                    username: db_user,
                    password: db_pass
                   )
      
      # Create Admin User
      Admin.create(:email = username, 
                   :encrypted_password= encrypted_password(password, create_new_salt), 
                   :role = role)
    end  
  end
  
  def role
    'administrator'
  end
    
  def create_new_salt
		self.object_id.to_s + rand.to_s
	end
	  
	def encrypted_password(password, salt)
		string_to_hash = password + "dbseeder" + salt 
		Digest::SHA1.hexdigest(string_to_hash)
  end
  
end #--
