require_relative 'library'

lib = Library.new

lib.generate_books(20)
lib.generate_readers(100)
lib.generate_orders(100)


puts '----------------------'
puts lib.most_popular_books
puts '----------------------'
puts lib.most_popular_books(3)
puts '----------------------'
puts '----------------------'
puts lib.top_readers
puts '----------------------'
puts lib.top_readers(3)
puts '----------------------'
puts '----------------------'
puts lib.popular_books_readers
puts '----------------------'
puts lib.popular_books_readers(1)
puts '----------------------'

# path = lib.save_to_files

# p lib

# lib2 = Library.new
# lib2.load_from_files(path)
# p lib2

# puts lib == lib2
