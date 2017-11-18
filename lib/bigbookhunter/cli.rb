class BigBookHunter::CLI

	def call
		puts "Welcome to Big Book Hunter!"
		list_books
		menu
		goodbye
	end

	def list_books
		@books = BigBookHunter::Book.current
		@books.each.with_index(1) do |book, i|
			puts "#{i}. #{book.dealer} - #{book.author}. #{book.title}. #{book.year}. #{book.price}."
		end
	end

	def menu
		puts "Enter the book number for more information, type \'list\' to see all books again, or type \'exit.\'"
		input = nil
		while input != "exit"
			input = gets.strip.downcase
			if input.to_i > 0
				the_book = @books[input.to_i-1]
				puts "#{the_book.dealer} - #{the_book.author}. #{the_book.title}. #{the_book.year}. #{the_book.price}."
			elsif input == 'list'
				list_books
			else
				puts "Not sure what you want. Type \'list\' or \'exit\'."
			end
		end
	end

	def goodbye
		puts "See you tomorrow for more books!"
	end
end