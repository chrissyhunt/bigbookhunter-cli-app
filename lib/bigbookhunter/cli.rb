class BigBookHunter::CLI

	def call
		puts "Welcome to Big Book Hunter!"
		list_books
		menu
		goodbye
	end

	def list_books
		puts "The new books on the market today are:"
		puts "1. WILLIAM REESE - HAMILTON, Alexander. The Federalist. 1788. $185,000."
		puts "2. BAUMAN RARE BOOKS - VOLTAIRE. Candide. 1759. $65,000."
	end

	def menu
		puts "Enter the book number for more information, type \'list\' to see all books again, or type \'exit.\'"
		input = nil
		while input != "exit"
			input = gets.strip.downcase
			case input
			when "1"
				puts "More info on The Fedearlist at William Reese."
			when "2"
				puts "More info on Candide at Bauman Rare Books."
			when "list"
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