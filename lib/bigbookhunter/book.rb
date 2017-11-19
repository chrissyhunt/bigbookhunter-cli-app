class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url

	@@books = []

	def self.current
		puts "The big books on the market today are:"
		self.scrape_books
	end

	def self.scrape_books
		@@books << self.scrape_ABE
		# books << self.scrape_dealers

		@@books
	end

	def self.scrape_ABE
		all_books = Nokogiri::HTML(open("https://www.abebooks.com/servlet/SearchResults?bi=0&bx=off&ds=50&kn=.&prl=10000&recentlyadded=2day&sortby=1&cm_sp=pan-_-srp-_-rate")).css("div.result-set").css("div.result-detail")
		all_books.each do | abe_book |
			the_book = self.new
			the_book.dealer = abe_book.css("div.bookseller-info").css("p").css("a").attr("title").value
			the_book.title = abe_book.css("a").attr("title").value
			the_book.author = abe_book.css("p.author").css("strong").inner_text
			the_book.price = abe_book.css("meta[itemprop='price']").attr("content").value
			the_book.url = abe_book.css("a").attr("href").value
			
			# Fix for listings that don't include a publication date
			if abe_book.include?("datePublished")
				the_book.year = abe_book.css("meta[itemprop='datePublished']").attr("content").value
			else
				the_book.year = "DATE UNKNOWN"
			end

			# Spam filter for bad dealers
			if the_book.dealer.downcase != ("Ergodebooks".downcase || "Bookdonors CIC".downcase || "FORTIUS LTD".downcase || "Ruslania".downcase || "Mediaoutlet12345".downcase)
				@@books << the_book
			end			
		end
	end

end
