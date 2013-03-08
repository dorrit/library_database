require 'spec_helper'

describe ZipCode do
  context '#valid?' do 
    it 'returns true for a valid zip code' do
      zip_code = ZipCode.new('92092')
      zip_code.valid?.should be_true
    end

    it 'returns false for a zip code' do
      zip_code = ZipCode.new('b3rkeley')
      zip_code.valid?.should be_false
    end

    it 'normalizes the zip to five digits, if more are provided' do
      zip_code = ZipCode.new('95811-213')
      zip_code.code.should eq '95811'
    end
  end
end