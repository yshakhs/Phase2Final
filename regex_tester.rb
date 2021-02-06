class RegexTester

    attr_accessor :statements, :pattern
	def initialize (pattern="", statements)  
		#  title, f and l are local variables
		@pattern = pattern
		@statements = statements

	end 

	def test
		@statements.each { |statement| if pattern_matches? statement
				puts "MATCH: #{statement}"
			  else
				STDERR.puts "NO MATCH: #{statement}"
			  end
			}
	end 


	  private
	def pattern_matches? statements
		statements.match(@pattern) != nil
	end
end


#pattern =  /^(http:\/\/)?www\.\w+\.(com|edu|org)$/  # from test_arrays.rb
#statement = "http://www.google.com"
#regex = RegexTester.new(pattern, statement)
#puts regex.pattern
#puts regex.statements


puts "------"
#regex.test
#regex.statements = "apidock.com"
#regex.test


arr = %w(http://www.google.com apidock.com www.microsoft.com http://www.bouzidi-family.org http://www.kli.org http://www.acac.net http://www.cmu.edu http://is.hss.cmu.edu www.amazon.co.uk)
pattern2 = /^(http:\/\/)?www\.\w+\.(com|edu|org)$/

regex2 = RegexTester.new(pattern2, arr)
puts regex2.pattern
puts regex2.statements
puts "------"
regex2.test
puts "--------------------------"
statement_array=%w(1234567890123456 1234-5678-9012-3456 1234\ 5678\ 9012\ 3456 1234567890 1234|5678|9012|3456 12345678901234567)
# ```
# We will build the pattern slowly and in steps listed below.

#2. Allow for just 16 digits by adding 

#```ruby 
 p= /^\d{16}$/
 cc = RegexTester.new(p, statement_array)
 cc.test

 puts "------"
 cc.pattern = /^\d{16}$|^(\d{4}-\d{4}-\d{4}-\d{4})$/
 cc.test

 puts "------"
 cc.pattern = /^\d{16}$|^((\d{4}-){4})$/
 cc.test
 puts "------"


 cc.pattern = /^\d{16}$|^((\d{4}-?){4})$/
 cc.test
 puts "------"


 cc.pattern = /^\d{16}$|^(\d{4}[ -]?){4}$/
  cc.test

  puts "------"
  cc.pattern = /^(\d{4}[ -]?){4}$/
  cc.test
