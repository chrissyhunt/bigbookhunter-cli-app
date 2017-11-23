# BIG BOOK HUNTER CLI APP

Goal: will scrape ABE (and eventually dealer pages) to list new "big books" on the rare books market.

(Following video...)

Steps:
1. Use gem bundler to generate file structure
2. Build CLI interface
3. Stub out user interface (menus, list of books, etc.)
3. Start scraping real data
4. Clean up report
5. ABE scraper working -> add ABAA scraper! (See steps above.)

What is a book?
- Has an author, title, year published
- Has a dealer listing it
- Has a list price
- Has a URL for more info
- Has a description of historical/cultural value (???)

ABE Dealers to exclude:
Ergodebooks
Bookdonors CIC
FORTIUS LTD
Ruslania
Mediaoutlet12345
PreLoved ltd
Lost Books

NEEDS WORK:
- Add dealer website scraper
- Create "Dealer" class to keep track of spam posters, contact info for dealers listed?
