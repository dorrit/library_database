require './lib/media'
require 'pg'
DB = PG.connect(:dbname => 'library', :host => 'localhost')

PLEASE_SELECT = "\n\nPlease select from the above, or 'x' exit:"

def welcome
  puts "WELCOME TO YOUR PUBLIC LIBRARY!\n\n"
  main_menu
end

def main_menu

  choice = nil
  until choice == 'x'
    puts "Tell us what kind of user you are\n\n"
    puts "        USER MENU  \n\n"
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

def patron_menu
  choice = nil
  puts "\n\nWelcome, Library Patron!\n\n"
  until choice == 'x'
    puts "\n\n   MAIN MENU"
    puts "   1. Look up an item"
    puts "   2. Reserve an item"
    puts "   3. Renew an item"
    puts "   4. Check item status"
    puts "   5. Create a user account"
    puts PLEASE_SELECT
    choice = gets.chomp
    case choice
    when '1'
      search
    when '5'
      create_account
    else 
      invalid
    end
  end
end

def librarian_menu
  choice = nil
  puts "\n\nWelcome, librarian!\n\n"
  until choice == 'x'
    puts "\n\n       MAIN MENU"
    puts "   1. Add an item"
    puts "   2. Delete an item"
    puts "   3. Edit an item"
    puts "   4. Check out a book"
    puts PLEASE_SELECT
    choice = gets.chomp
    case choice
    when '1'
      add
    when '2'
      delete
    when '3'
      edit_menu
    when '4'
      check_out
    else 
      invalid
    end
  end
end
def check_out
 patron = search_patron
 media = search
 patron.check_out(media)
 "#{title} is checked out.  Please let the patron know it is due on #{due_date}."
 puts "Is there another book that this patron would like to check out? (y/n)"
 check_out if gets.chomp == 'y'
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

def create_account
  puts "\n\nWe are delighted that you are creating an account!"
  puts "\n\nEnter your first name"
  first_name = gets.chomp
  puts "\n\nEnter your last name"
  last_name = gets.chomp
  puts "\n\nEnter your email address"
  email = gets.chomp
  puts "\n\nEnter your primary phone number, area code first, in this format xxx-xxx-xxxx"
  phone = gets.chomp
  puts "\n\nEnter your street address"
  street = gets.chomp
  puts "\n\nEnter your city"
  city = gets.chomp
  puts "\n\nEnter the two-digit abbreviation for your state"
  state = gets.chomp
  puts "\n\nEnter your zip code"
  zip_code = gets.chomp


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
    puts  "   #{media_array[choice-1].print_record}" unless media_array == nil
    media_array[choice-1]
end

def search_patron
    puts "what is the patron's last name?"    
    last_name = gets.chomp
    patron_array = Patron.search(key_word)
    puts "Here are patrons that match your search. Choose which one you want."
    patron_array.each_with_index {|patron, i| puts "   #{i+1}. #{patron.print_record}" }
    #Patron.search('Hesse').each { |patron| p patron.print_record }
    choice = gets.chomp.to_i
    puts "Here is the item you chose: "
    #if nothing found, say so
    puts  "   #{patron_array[choice-1].print_record}" unless patron_array == nil
    patron_array[choice-1]
end

def delete
  media = search
  puts "Are you sure you want to delete this title? (y/n)"
  media.delete if gets.chomp == 'y'
end

def edit_menu
  media = search
  fields = ['first_name','last_name','title','subject','genre']
  choice = nil
   until choice == 'x'
    puts "\n\n       EDIT MENU"
    puts "   1. Edit author's first name:  #{media.first_name}"
    puts "   2. Edit author's last name:  #{media.last_name}"
    puts "   3. Edit title:  #{media.title}"
    puts "   4. Edit subject:  #{media.subject}"
    puts "   5. Edit genre:  #{media.genre}"
    puts PLEASE_SELECT
    choice = gets.chomp
    edit(media, fields[choice.to_i-1]) unless choice == 'x'
  end
end

def edit(media, column)
  puts "What would you like to change it to?"
  input = gets.chomp
  media.edit(column, input)
end

def invalid 
  puts "Invalid choice, loser!\n\n"
  main_menu
end

welcome