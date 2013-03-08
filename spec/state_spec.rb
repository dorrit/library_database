require 'spec_helper'

describe State do
  context '#valid?' do 
    it 'returns true for a valid state abbreviation' do
      state = State.new('CA')
      state.valid?.should be_true
    end

    it 'returns false for a nonexistent state abbreviation' do
      state = State.new('qweqw')
      state.valid?.should be_false
    end

    it 'normalizes the state abbreviation to upper case' do
      state = State.new('wa')
      state.abbrev.should eq 'WA'
    end
  end
end