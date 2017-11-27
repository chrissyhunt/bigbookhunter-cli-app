class BigBookHunter::Book
	attr_accessor :dealer, :author, :title, :year, :price, :url, :description, :list_source

	@@books = []

	def self.current
		puts "The new big books on the market today are:"
		puts " "
		BigBookHunter::Scraper.new
		BigBookHunter::Scraper.import_books
	end

	def self.all_books
		@@books
	end

	def save
		@@books << self
	end

	def self.clear_all
		@@books.clear
	end

end
