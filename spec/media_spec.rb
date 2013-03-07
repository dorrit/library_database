require 'spec_helper'

describe Media do

  context 'attr_readers' do
    it 'should return the value for first_name, last_name, title, subject, genre' do
      attributes = {'first_name' => 'Charles', 
                    'last_name' => 'Duhigg', 
                    'title' => 'The Power of Habit', 
                    'genre' => 'Non-fiction', 
                    'subject' => 'Psychology' }
      media = Media.new(attributes)
      media.first_name.should eq 'Charles'
      media.last_name.should eq 'Duhigg'
      media.title.should eq 'The Power of Habit'
      media.genre.should eq 'Non-fiction'
      media.subject.should eq 'Psychology'
    end
  end

  context '#initialize' do
    it 'accepts a hash of media info as its argument' do
      media_info = {'title' => 'Demian', 'first_name' => 'Herman', 'last_name' => 'Hesse'}
      media = Media.new(media_info)
      media.should be_an_instance_of Media
    end
  end

  context '#save' do
    it 'saves the media info to the database' do
      media = Media.new({'title' => 'Principia Discordia'})
      expect {media.save}.to change {Media.all.length}.by 1
    end
  end

  context '.all' do
    it 'lists all of the media in the library database' do
      titles = ['Demian', 'Confederacy of Dunces', 'Diamond Age']
      titles.each {|title| Media.new({'title' => title}).save}
      Media.all.map {|media| media.title}.should =~ titles
    end
  end

  context '.search' do
    it 'takes match criteria as argument and returns matching records from any column in the media table.' do
      media_info = {'title' => 'Demian', 'first_name' => 'Herman', 'last_name' => 'Hesse'}
      media = Media.new(media_info)
      media.save
      first_found_media = Media.search('Hesse')[0]
      Media.search('Hesse').each { |media| p media.print_record }
      first_found_media.title.should eq 'Demian'  
    end
    it 'takes match criteria and an optional column name as arguments and returns matching records from the media table, in only that column name.'
  end

  context '#print_record' do
    it 'outputs a string of all the media info on a single line' do
         attributes = {'first_name' => 'Charles', 
                    'last_name' => 'Duhigg', 
                    'title' => 'The Power of Habit', 
                    'genre' => 'Non-fiction', 
                    'subject' => 'Psychology' }
      media = Media.new(attributes)
      media.save
      media.print_record.should eq "Charles Duhigg, The Power of Habit, Non-fiction, Psychology"
    end
  end
end