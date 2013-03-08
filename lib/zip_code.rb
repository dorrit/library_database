class ZipCode

  attr_reader :code

  def initialize(code)
    @code = code.split('-')[0]
  end

  def valid?
    #make sure it is 5 numerals
    (/^\d{5}{1}$/ =~ @code) != nil ? true : false 
  end

end
