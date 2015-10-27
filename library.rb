require 'fileutils'
require 'faker'
require "as-duration"
require 'csv'

require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'reader'

class Library
  attr_accessor :authors, :books, :orders, :readers

  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
  end

  def add_author(author)
    @authors << author
  end

  def add_book(book)
    @books << book
    add_author(book.author)
  end

  def add_order(order)
    @orders << order
  end

  def add_reader(reader)
    @readers << reader
  end

  def ==(other)
    authors == other.authors && books == other.books && orders == other.orders && readers == other.readers
  end

  def most_popular_books(count = 1)
    book_popularity = Hash.new(0)
    orders.each{|o| book_popularity[o.book.to_s] += 1}
    book_popularity.sort_by{|book, popularity| popularity}.reverse.first(count).map{|b| b[0]}
  end

  def top_readers(count = 1)
    readers_rank = Hash.new(0)
    orders.each{|o| readers_rank[o.reader.to_s] += 1}
    readers_rank.sort_by{|reader, rank| rank}.reverse.first(count).map{|r| r[0]}
  end

  def popular_books_readers(pop_book_count = 3)
    pop_books = most_popular_books(pop_book_count)
    orders.select{|o| pop_books.include?("#{o.book.title} by #{o.book.author}")}.map{|o| o.reader}.uniq
  end

  def save_to_files
    path = "dumps/#{Time.now.strftime("%Y%m%dT%H%M%S")}" 
    FileUtils.mkpath(path)
      CSV.open("#{path}/authors.csv", "wb") do |csv|
        authors.each {|a| csv << a.prepare_to_csv}
      end
      CSV.open("#{path}/books.csv", "wb") do |csv|
        books.each{|b| csv << b.prepare_to_csv}
      end
      CSV.open("#{path}/orders.csv", "wb") do |csv|
        orders.each{|o| csv << o.prepare_to_csv}
      end
      CSV.open("#{path}/readers.csv", "wb") do |csv|
        readers.each{|r| csv << r.prepare_to_csv}
      end
      path
  end

  def load_from_files (path)
    @authors = CSV.read("#{path}/authors.csv").map!{|a| Author.new(a[0], a[1])}
    @books   = CSV.read("#{path}/books.csv").map!{|b| Book.new(b[0], authors.find(''){|a| a.name == b[1]})}
    @readers = CSV.read("#{path}/readers.csv").map!{|r| Reader.new(r[0], r[1], r[2], r[3], r[4])}
    @orders  = CSV.read("#{path}/orders.csv").map!{|o| Order.new(books.find(''){|b| "#{b.title} by #{b.author}" == o[0]}, readers.find(''){|r| r.name == o[1]}, Time.at(o[2].to_i))}
    'Data loaded.'
  end

  def generate_books(count)
    count.times do
      author_name = Faker::Name.name
      a = authors.find{|a| a.name == author_name}
      unless a
        a = Author.new(author_name, Faker::Lorem.paragraph)
      end
      add_book(Book.new(Faker::Book.title, a))

    end
  end

  def generate_readers(count)
    count.times do
      r = Reader.new(Faker::Name.name,
        Faker::Internet.email, 
        Faker::Address.city,
        Faker::Address.street_name,
        Faker::Address.building_number)
      add_reader(r)
    end
  end

  def generate_orders(count)
    count.times do
      add_order(Order.new(books.sample, readers.sample, Faker::Time.between(100.days.ago, Time.now, :day)))
    end
  end

end
