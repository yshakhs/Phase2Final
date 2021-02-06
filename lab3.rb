class User

    attr_accessor :id, :firstname, :lastname, :password
	def initialize (id, firstname, lastname, password)  
		#  title, f and l are local variables
		@id = id
		@firstname = firstname
        @lastname = lastname
        @password = password

	end 

    def get_full_name
        
        first_and_last_name = @firstname + " "+ @lastname
		first_and_last_name
	end

	def check_password(p)
		p==@password
	end
end

u1= User.new("1111", "Yara", "Alshakhs", "12345")
puts u1.id
puts u1.firstname
puts u1.lastname
puts u1.password
puts u1.get_full_name
puts u1.check_password("abc")
puts u1.check_password("12345")

class Tweet

    attr_accessor :owner, :message
	def initialize (owner, message)  
		#  title, f and l are local variables
		@owner = owner
        @message = message
        
        if @message.length>=140 
            @message = @message[0..140]
        end
	end 

    def get_hashtags
        
        message1 = @message.split(" ")
        list=[]
		message1.each do | word |
            if word[0,1]=="#"
                    list += [word]
            end
        end
        list
	end


    def to_s
        full_message = @owner+ 'said, "'+ @message + '"'
        full_message
    end

end

t1= Tweet.new("Houda Bouamor", "The next assignment in #cmuq67272 will be #easy")
puts t1.owner
puts t1.message
puts t1.get_hashtags
puts t1.to_s

class Tweeter

    attr_accessor :users, :tweets
	def initialize ()  
        @users = []
        @tweets = []
    
	end 

    def signup(id, password, firstname, lastname)
        @users.each do | user |
	    if user.include? id
                    false
            end
            Utemp=User.new(id, password, firstname, lastname)
            @users +=[[id, password, firstname, lastname]]
            true
        end
	end

    
    def signin(id, password)
        @users.each do | user |
            if user[0]== id and user[1]== password
            true
        end
        nil
    end

    def add_tweet(user, message)

        Tweet.new(user, message)
    @tweets+=[message]
    end

    def to_str

        if tweets.length()>20
            lengths=tweets.length()
            beginin=lengths-20
        tweet1 = tweets.split[beginin..lengths]
        tweets1.each do | tweet |
            puts tweet
        end
        else
            @tweets.each do | tweet |
                puts tweet
            end
        end

    end

end










