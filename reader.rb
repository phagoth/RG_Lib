class Reader
  attr_reader :name
  attr_accessor :email, :city, :street, :house

  def initialize (name, email = '', city = '', street = '', house = '')
    @name   = name
    @email  = email
    @city   = city
    @street = street
    @house  = house
  end

  def to_s
    @name
  end

  def inspect
    "
    Name:   #{@name}
    Email:  #{@email}
    City:   #{@city}
    Street: #{@street}
    House:  #{@house}"
  end

  def prepare_to_csv
    [name, email, city, street, house]
  end

  def ==(other)
    name == other.name && email == other.email && city == other.city && street == other.street && house == other.house
  end

end
