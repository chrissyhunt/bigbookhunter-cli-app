class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url

	def self.current
		puts "The big books on the market today are:"
		self.scrape_books
	end

	def self.scrape_books
		books = []

	#Go to ABE, find books
	#Scrape properties
	#Instantiate a book
	#Eventually expand to dealer pages

		books << self.scrape_ABE

		book_1 = self.new
		book_1.dealer = "WILLIAM REESE"
		book_1.author = "HAMILTON, Alexander"
		book_1.title = "The Federalist"
		book_1.year = "1788"
		book_1.price = "$185,000"
		book_1.url = "http://www.billreesetest.com"
		books << book_1

		book_2 = self.new
		book_2.dealer = "BAUMAN RARE BOOKS"
		book_2.author = "VOLTAIRE"
		book_2.title = "Candide"
		book_2.year = "1759"
		book_2.price = "$65,000"
		book_2.url = "http://www.brbtest.com"
		books << book_2

		books
	end

	def self.scrape_ABE
		
	end

end
