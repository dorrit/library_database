class Street

attr_reader :street_name

  def initialize(street_name)
    @street_name = street_name.split(' ').map {|street_word| street_word.capitalize}.join(' ')
  end

  def valid?
     (/(^\d+[a-zA-Z]*\s)([a-zA-Z\s#.,\d]+$)/ =~ @street_name) != nil
  end

end