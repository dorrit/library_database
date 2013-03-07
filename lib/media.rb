class Media
  
  attr_reader :title, :last_name, :first_name, :subject, :genre

  def initialize(media_info)
    @title = media_info['title']
    @last_name = media_info['last_name']
    @first_name = media_info['first_name']
    @subject = media_info['subject']
    @genre = media_info['genre']
  end

  def save
    author_id = DB.exec("INSERT INTO author (first_name, last_name) VALUES ('#{first_name}', '#{last_name}') RETURNING id;").map {|result| result['id']}[0]
    title_id = DB.exec("INSERT INTO title (title) VALUES ('#{title}') RETURNING id;").map {|result| result['id']}[0]
    subject_id = DB.exec("INSERT INTO subject (subject) VALUES ('#{subject}') RETURNING id;").map {|result| result['id']}[0]
    genre_id = DB.exec("INSERT INTO genre (genre) VALUES ('#{genre}') RETURNING id;").map {|result| result['id']}[0]
    DB.exec("INSERT INTO media (author_id, title_id, subject_id, genre_id) VALUES ('#{author_id}', '#{title_id}', '#{subject_id}', '#{genre_id}') RETURNING id;")
  end

  def self.all
    DB.exec("SELECT author.first_name, author.last_name, title.title, subject.subject, genre.genre 
             FROM author, title, subject, genre, media
             WHERE media.author_id = author.id 
             AND media.title_id = title.id 
             AND media.subject_id = subject.id 
             AND media.genre_id = genre.id").inject([]) {|medias, media_hash| medias << Media.new(media_hash)}
  end

  def self.search(input,column='')
       DB.exec("SELECT author.first_name, author.last_name, title.title, subject.subject, genre.genre 
             FROM author, title, subject, genre, media
             WHERE media.author_id = author.id 
             AND media.title_id = title.id 
             AND media.subject_id = subject.id 
             AND media.genre_id = genre.id
             AND (author.first_name LIKE '%#{input}%'
             OR  author.last_name LIKE '%#{input}%'
             OR title.title LIKE '%#{input}%'
             OR subject.subject LIKE '%#{input}%'
             OR genre.genre LIKE '%#{input}%')").inject([]) {|medias, media_hash| medias << Media.new(media_hash)}
  end

  def print_record
    "#{@first_name} #{@last_name}, #{@title}, #{@genre}, #{@subject}"
  end
end