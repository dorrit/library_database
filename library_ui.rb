require './lib/media'
require 'pg'
DB = PG.connect(:dbname => 'library', :host => 'localhost')

PLEASE_SELECT = "\n\nPlease select from the above, or 'x' exit:"

def welcome
  puts "Welcome to your public library!\n\n\n"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'
    puts "Tell us what kind of user you are\n\n"
    puts "   1. Librarian access"
    puts "   2. Patron access"
    puts PLEASE_SELECT
    choice = gets.chomp
    case choice 
    when '1'
      librarian_menu
    when '2'
      patron_menu
    else
      invalid
    end
  end
end



def librarian_menu
  choice = nil
  puts "Welcome, librarian!\n\n"
  until choice == '4'
    puts "   1. Add an item"
    puts "   2. Delete an item"
    puts "   3. Edit an item"
    puts "   4. Return to main menu"
    puts PLEASE_SELECT
    choice = gets.chomp
    case choice
    when '1'
      add
    when '2'
      delete
    when '3'
      edit
    else 
      invalid
    end
  end
end

def add 
  puts "\n\nWhat title would you like to add?"
  title = gets.chomp
  puts "\n\nWhat is the author's last name?"
  last_name = gets.chomp
  puts "\n\nWhat is the author's first name?"
  first_name = gets.chomp
  puts "\n\nWhat is the subject?"
  subject = gets.chomp
  puts "\n\nWhat genre?"
  genre = gets.chomp

  puts "\n\nYou've entered the following info:"
  puts "   #{title} by #{first_name} #{last_name} "
  media  = Media.new({'title' => title, 'last_name' => last_name, 'first_name' => first_name, 'subject' => subject, 'genre' => genre})
  media.save
  puts "\n\nWould you like to add another title (y/n)?"
  add if gets.chomp == 'y'
end


def search
    puts "To search for an item, enter some key words to search? \n\n"
    key_word = gets.chomp
    media_array = Media.search(key_word)
    puts "Here are titles that match your search. Choose which one you want."
    media_array.each_with_index {|media, i| puts "   #{i+1}. #{media.print_record}" }
    #Media.search('Hesse').each { |media| p media.print_record }
    choice = gets.chomp.to_i
    puts "Here is the item you chose: "
    #if nothing found, say so
    puts  "   #{media_array[choice-1].print_record}"
    media_array[choice-1]
end

def delete
  media = search
  puts "Are you sure you want to delete this title? (y/n)"
  media.delete if gets.chomp == 'y'
end

def edit

end



def patron_menu

end




def invalid 
  puts "Invalid choice, loser!\n\n"
  main_menu
end

welcome