class BigBookHunter::CLI

	def call
		puts "---"
		puts " "
		puts "Welcome to Big Book Hunter!"
		list_books
		menu
		goodbye
	end

	def list_books
		puts " "
		@books = BigBookHunter::Book.current
		@books.each.with_index(1) do |book, i|
			puts "#{i}. #{book.dealer.upcase} - #{book.author[0..60]}. #{book.title[0..50]}. #{book.year}. #{book.price}."
		end
	end

	def menu
		puts " "
		puts "Enter the book number for more information, type \'list\' to see all books again, or type \'exit.\'"
		input = nil
		while input != "exit"
			input = gets.strip.downcase
			if input.to_i > 0
				the_book = @books[input.to_i-1]

				BigBookHunter::Book.scrape_ABAA_description(the_book, the_book.url) if the_book.list_source == "ABAA"
				
				puts "---"
				puts " "
				puts "DEALER: #{the_book.dealer}"
				puts "AUTHOR: #{the_book.author}"
				puts "TITLE: #{the_book.title}"
				puts "YEAR PUBLISHED: #{the_book.year}"
				puts " "
				puts "PRICE: #{the_book.price}"
				puts " "
				puts "ITEM DESCRIPTION: \n#{the_book.description}"
				puts " "
				puts "FOR MORE INFO: \n#{the_book.url}"
				puts " "
				puts "---"
				
			elsif input == 'list'
				list_books
			else
				puts "Not sure what you want. Type \'list\' or \'exit\'." unless input == "exit"
			end
		end
	end

	def goodbye
		puts " "
		puts "See you tomorrow for more books!"
		puts " "
		puts "---"
	end
end