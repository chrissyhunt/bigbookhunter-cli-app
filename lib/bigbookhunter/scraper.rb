class BigBookHunter::Scraper

	def self.import_books
		BigBookHunter::Book.clear_all
		scrape_ABE
		scrape_ABAA
		BigBookHunter::Book.all_books
	end

	def self.scrape_ABE
		all_books = Nokogiri::HTML(open("https://www.abebooks.com/servlet/SearchResults?bi=0&bx=off&ds=50&kn=.&prl=10000&recentlyadded=2day&sortby=1&cm_sp=pan-_-srp-_-rate")).css("div.result-set div.cf.result")
		all_books.each do | abe_book |
			the_book = BigBookHunter::Book.new
			# binding.pry
			the_book.dealer = abe_book.css("div.bookseller-info p a").attr("title").value
			the_book.title = abe_book.css("a span").inner_text
			the_book.author = abe_book.css("p.author strong").inner_text
			the_book.price = abe_book.css("div.item-price span.price").inner_text
			the_book.url = "http://www.abebooks.com#{abe_book.css("div.result-detail a").attr("href").value}"
			the_book.description = abe_book.css("p.clear-all span").inner_text
			the_book.list_source = "ABE"

			if abe_book.css("p#publisher").length > 0
				!abe_book.css("p#publisher span")[1] ? the_book.year = "DATE UNKNOWN" : the_book.year = abe_book.css("p#publisher span")[1].inner_text.match(/([0-9]{4})/)
			else
				the_book.year = "DATE UNKNOWN"
			end

			if !bad_seller?(the_book)
				the_book.save
			end			
		end
	end

	def self.scrape_ABAA
		all_books = Nokogiri::HTML(open("https://www.abaa.org/book/search/?action=search&added_after=3&fulltextadd=&sort=id_desc&results_per_page=100&author=&title=&fulltext=&publisher=&isbn=&minimum_price=10000&maximum_price=&minimum_publish_date=&maximum_publish_date=&format=&book_condition=")).css("section.box-book")
		all_books.each do | abaa_book |
			the_book = BigBookHunter::Book.new
			the_book.dealer = abaa_book.css("div.text strong.offered a").inner_text
			the_book.title = abaa_book.css("div.text h3 a").inner_text
			the_book.author = abaa_book.css("div.text p")[0].inner_text.slice(3..-1)
			the_book.price = abaa_book.css("div.cart-box span.cost").inner_text
			the_book.url = "https://www.abaa.org#{abaa_book.css("div.text h3 a").attr("href").value}"
			the_book.year = abaa_book.css("div.text p")[1].inner_text.match(/([0-9]{4})/)
			the_book.list_source = "ABAA"

			if !book_already_exists?(the_book)
				the_book.save
			end
		end
	end

	def self.scrape_ABAA_description(the_book, item_url)
		the_book.description = Nokogiri::HTML(open(item_url)).css("div.item-description").inner_text.gsub(/^\s*/, '')
	end

	def self.bad_seller?(the_book)
		the_book.dealer.match(/Ergodebooks|Bookdonors CIC|FORTIUS LTD|Ruslania|Mediaoutlet12345|PreLoved ltd|HPB-Diamond|Phoenix Antiquariat & Autographen|Lost Books|8trax Media|DontPayMore|Rem Distributors/)
	end

	def self.book_already_exists?(the_book)
		BigBookHunter::Book.all_books.any? do | book |
			# binding.pry
			book.dealer[0..10] == the_book.dealer[0..10] && book.title[0..20] == the_book.title[0..20]
		end	
	end		

end