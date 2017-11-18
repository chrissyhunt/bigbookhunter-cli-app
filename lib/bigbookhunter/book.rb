class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url

	def self.current
		#returns an array of currently available books
		#temp return:
		puts "The big books on the market today are:"
		# puts "1. WILLIAM REESE - HAMILTON, Alexander. The Federalist. 1788. $185,000."
		# puts "2. BAUMAN RARE BOOKS - VOLTAIRE. Candide. 1759. $65,000."

		book_1 = self.new
		book_1.dealer = "WILLIAM REESE"
		book_1.author = "HAMILTON, Alexander"
		book_1.title = "The Federalist"
		book_1.year = "1788"
		book_1.price = "$185,000"
		book_1.url = "http://www.billreesetest.com"

		book_2 = self.new
		book_2.dealer = "BAUMAN RARE BOOKS"
		book_2.author = "VOLTAIRE"
		book_2.title = "Candide"
		book_2.year = "1759"
		book_2.price = "$65,000"
		book_2.url = "http://www.brbtest.com"

		return [book_1, book_2]
	end

end
