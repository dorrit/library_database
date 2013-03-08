require 'spec_helper'

describe Street do
  context '#valid?' do 
    it 'returns true for a valid street name' do
      street = Street.new('1715 I st.')
      street.valid?.should be_true
    end

    it 'returns false for a  street name' do
      street = Street.new('b3rkeley')
      street.valid?.should be_false
    end

    it 'normalizes the street to title case' do
      street = Street.new('little roCk')
      street.street_name.should eq 'Little Rock'
    end
  end
end