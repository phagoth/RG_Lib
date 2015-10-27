require_relative 'book'
require_relative 'reader'

class Order
  attr_reader :book, :reader, :date

  def initialize (book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "#{book}, ordered by #{reader} at #{date}"
  end

  def inspect
    "
    Book:   #{book}
    Reader: #{reader}
    Date:   #{date}"
  end

  def prepare_to_csv
    [book, reader, date.to_i]
  end

  def ==(other)
    book == other.book && reader == other.reader && date == other.date
  end
end
