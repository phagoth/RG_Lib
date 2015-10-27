require_relative 'author'

class Book
  attr_reader :title, :author

  def initialize (title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{title} by #{author}"
  end

  def inspect
    "
    Title:  #{title}
    Author: #{author}"
  end

  def prepare_to_csv
    [title, author]
  end

  def ==(other)
    title == other.title && author == other.author
  end
end
