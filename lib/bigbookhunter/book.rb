class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url

	def self.current
		puts "The big books on the market today are:"
		self.scrape_books
	end

	def self.scrape_books
		books = []

		books << self.scrape_ABE
		# books << self.scrape_dealers

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
		doc = Nokogiri::HTML(open("https://www.abebooks.com/servlet/SearchResults?bi=0&bx=off&ds=50&kn=.&prl=10000&recentlyadded=2day&sortby=1&cm_sp=pan-_-srp-_-rate")).css("div.result-set")
		binding.pry
		# dealer = doc.css("div.result-detail").first.css("div.bookseller-info").css("p").css("a").attr("title").value
		# title = doc.css("div.result-detail").first.css("a").attr("title").value
		# author = doc.css("div.result-detail").first.css("p.author").css("strong").inner_text
		# year = doc.css("div.result-detail").first.css("meta[itemprop='datePublished']").attr("content").value
		# price = doc.css("div.result-detail").first.css("meta[itemprop='price']").attr("content").value
		# url = doc.css("div.result-detail").first.css("a").attr("href").value
	end

end
