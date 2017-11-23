class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url, :description, :list_source

	@@books = []

	def self.current
		puts "The new big books on the market today are:"
		puts " "
		self.scrape_books
	end

	def self.clear_all
		@@books.clear
	end

	def self.scrape_books
		self.clear_all
		self.scrape_ABE
		self.scrape_ABAA
		#self.scrape_dealers (?)

		@@books
	end

	def self.scrape_ABE
		all_books = Nokogiri::HTML(open("https://www.abebooks.com/servlet/SearchResults?bi=0&bx=off&ds=50&kn=.&prl=10000&recentlyadded=2day&sortby=1&cm_sp=pan-_-srp-_-rate")).css("div.result-set").css("div.cf.result")
		all_books.each do | abe_book |
			the_book = self.new
			the_book.dealer = abe_book.css("div.bookseller-info").css("p").css("a").attr("title").value
			the_book.title = abe_book.css("a").css("span").inner_text
			the_book.author = abe_book.css("p.author").css("strong").inner_text
			the_book.price = abe_book.css("div.item-price").css("span.price").inner_text
			the_book.url = "http://www.abebooks.com#{abe_book.css("div.result-detail").css("a").attr("href").value}"
			the_book.description = abe_book.css("p.clear-all").css("span").inner_text
			the_book.list_source = "ABE"

			# Fix for listings that don't include a publication date
			if abe_book.css("p#publisher").length > 0
				# binding.pry
				if !abe_book.css("p#publisher").css("span")[1]
					the_book.year = "DATE UNKNOWN"
				else
					the_book.year = abe_book.css("p#publisher").css("span")[1].inner_text.match(/([0-9]{4})/)
				end
			else
				the_book.year = "DATE UNKNOWN"
			end

			# Spam filter for bad dealers
			if !the_book.dealer.match(/Ergodebooks|Bookdonors CIC|FORTIUS LTD|Ruslania|Mediaoutlet12345|PreLoved ltd|HPB-Diamond|Phoenix Antiquariat & Autographen|Lost Books/)
				@@books << the_book
			end			
		end


	end

	def self.scrape_ABAA
		all_books = Nokogiri::HTML(open("https://www.abaa.org/book/search/?action=search&added_after=3&fulltextadd=&sort=id_desc&results_per_page=100&author=&title=&fulltext=&publisher=&isbn=&minimum_price=10000&maximum_price=&minimum_publish_date=&maximum_publish_date=&format=&book_condition=")).css("section.box-book")
		all_books.each do | abaa_book |
			the_book = self.new
			the_book.dealer = abaa_book.css("div.text").css("strong.offered").css("a").inner_text
			the_book.title = abaa_book.css("div.text").css("h3").css("a").inner_text
			the_book.author = abaa_book.css("div.text").css("p")[0].inner_text.slice(3..-1)
			the_book.price = abaa_book.css("div.cart-box").css("span.cost").inner_text
			the_book.url = "https://www.abaa.org#{abaa_book.css("div.text").css("h3").css("a").attr("href").value}"
			the_book.year = abaa_book.css("div.text").css("p")[1].inner_text.match(/([0-9]{4})/)
			the_book.list_source = "ABAA"
			# description ==> need helper method!

			# Check for dupes -- working, I think?
			book_already_exists = @@books.any? do | book |
				book.dealer[0..10] == the_book.dealer[0..10] && book.title[0..20] == the_book.title[0..20]
			end

			if !book_already_exists && !the_book.dealer.match(/Ergodebooks|Bookdonors CIC|FORTIUS LTD|Ruslania|Mediaoutlet12345|PreLoved ltd|HPB-Diamond|Phoenix Antiquariat & Autographen|Lost Books/)
				@@books << the_book
			end
		end
	end

	def self.scrape_ABAA_description(the_book, item_url)
		the_book.description = Nokogiri::HTML(open(item_url)).css("div.item-description").inner_text.gsub(/^\s*/, '')
	end

end
