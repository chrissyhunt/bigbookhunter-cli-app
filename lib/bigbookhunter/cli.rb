class BigBookHunter::CLI

	def call
		puts "Welcome to Big Book Hunter!"
		puts "The new books on the market today are:"
		list_books
	end

	def list_books
		puts "1. WILLIAM REESE - HAMILTON, Alexander. The Federalist. 1788. $185,000."
		puts "2. BAUMAN RARE BOOKS - VOLTAIRE. Candide. 1759. $65,000."
	end
end