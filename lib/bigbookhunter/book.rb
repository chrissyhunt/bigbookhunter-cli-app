class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url, :description

	@@books = []

	def self.current
		puts "The big books on the market today are:"
		self.scrape_books
	end

	def self.scrape_books
		self.scrape_ABE
		# self.scrape_dealers

		@@books
	end

	def self.scrape_ABE
		all_books = Nokogiri::HTML(open("https://www.abebooks.com/servlet/SearchResults?bi=0&bx=off&ds=50&kn=.&prl=10000&recentlyadded=2day&sortby=1&cm_sp=pan-_-srp-_-rate")).css("div.result-set").css("div.cf.result")
		# binding.pry
		all_books.each do | abe_book |
			the_book = self.new
			the_book.dealer = abe_book.css("div.bookseller-info").css("p").css("a").attr("title").value
			the_book.title = abe_book.css("a").css("span").inner_text
			the_book.author = abe_book.css("p.author").css("strong").inner_text
			the_book.price = abe_book.css("div.item-price").css("span.price").inner_text
			the_book.url = "http://www.abebooks.com#{abe_book.css("div.result-detail").css("a").attr("href").value}"
			the_book.description = abe_book.css("p.clear-all").css("span").inner_text
			
			# Fix for listings that don't include a publication date
			if abe_book.include?("datePublished")
				the_book.year = abe_book.css("meta[itemprop='datePublished']").attr("content").value
			else
				the_book.year = "DATE UNKNOWN"
			end

			# Spam filter for bad dealers
			if !the_book.dealer.match(/Ergodebooks|Bookdonors CIC|FORTIUS LTD|Ruslania|Mediaoutlet12345|PreLoved ltd/)
				@@books << the_book
			end			
		end


	end

end
