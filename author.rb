class Author
  attr_reader :name
  attr_accessor :biography

  def initialize (name, bio = '')
    @name = name
    @biography = bio
  end

  def to_s
    name
  end

  def inspect
    "
    Name: #{name}
    Biography:
          #{biography}"
  end

  def prepare_to_csv
    [name, biography]
  end

  def ==(other)
    name == other.name && biography == other.biography
  end
end
