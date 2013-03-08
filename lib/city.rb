class City

attr_reader :name

  def initialize(name)
    @name = name.split(' ').map { |city_word| city_word.capitalize }.join(' ')
  end

  def valid?
    (/[^a-zA-Z]/ =~ @name) == nil ? true : false
  end

end

