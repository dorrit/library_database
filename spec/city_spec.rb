require 'spec_helper'

describe City do
  context '#valid?' do 
    it 'returns true for a valid city name' do
      city = City.new('Sacramento')
      city.valid?.should be_true
    end

    it 'returns false for a non-alphabetical city name' do
      city = City.new('b3rkeley')
      city.valid?.should be_false
    end

    it 'normalizes the city to title case' do
      city = City.new('little roCk')
      city.name.should eq 'Little Rock'
    end
  end
end