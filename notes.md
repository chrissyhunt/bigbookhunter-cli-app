# BIG BOOK HUNTER CLI APP

Goal: will scrape ABE (and eventually dealer pages) to list new "big books" on the rare books market.

(Following video...)

Steps:
1. Use gem bundler to generate file structure
2. Build CLI interface
3. Stub out user interface (menus, list of books, etc.)
3. Start scraping real data
4. Clean up report

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

ERRORS:
- list_books scrapes again and adds to global array every time it's run (because of Book.current) -- add "clear" method? (at beginning of scrape)

NEEDS WORK:
- Add dealer website scraper
- Currency type & formatting
- General formatting: trim list titles, currency, spacing
- Individual item "more info" readout
- Add total "count" to intro message?
- Format author names
- Eliminate duplicate listings?