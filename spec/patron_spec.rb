require 'spec_helper'

describe Patron do
  context '#print_record' do
    it 'outputs the first and last name and address of the patron.' do
         contact_info = {'first_name' => 'Charles', 
                    'last_name' => 'Duhigg', 
                    'street' => '1610 University Ave', 
                    'city' => 'Berkeley', 
                    'state' => 'CA' 
                    'zip_code' => '94703' }
      patron = Patron.new(contact_info)
      patron.save
      media.print_record.should eq "Charles Duhigg, The Power of Habit, Non-fiction, Psychology"
    end
  end

 context '#save' do
    it 'saves the media info to the database' do
      media = Media.new({'title' => 'Principia Discordia'})
      expect {media.save}.to change {Media.all.length}.by 1
    end
  end
  
  context '#check_out'
    it ''

  context '.search' do
    it 'takes match criteria as argument and returns matching records from any column in the media table.' do
      media_info = {'title' => 'Demian', 'first_name' => 'Herman', 'last_name' => 'Hesse'}
      media = Media.new(media_info)
      media.save
      first_found_media = Media.search('Hesse')[0]
      first_found_media.title.should eq 'Demian'  
    end
    it 'takes match criteria and an optional column name as arguments and returns matching records from the media table, in only that column name.'
  end

