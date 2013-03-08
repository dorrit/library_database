class Patron

def save
    author_id = DB.exec("INSERT INTO author (first_name, last_name) VALUES ('#{first_name}', '#{last_name}') RETURNING id;").map {|result| result['id']}[0]
    title_id = DB.exec("INSERT INTO title (title) VALUES ('#{title}') RETURNING id;").map {|result| result['id']}[0]
    subject_id = DB.exec("INSERT INTO subject (subject) VALUES ('#{subject}') RETURNING id;").map {|result| result['id']}[0]
    genre_id = DB.exec("INSERT INTO genre (genre) VALUES ('#{genre}') RETURNING id;").map {|result| result['id']}[0]
    @id = DB.exec("INSERT INTO media (author_id, title_id, subject_id, genre_id) VALUES ('#{author_id}', '#{title_id}', '#{subject_id}', '#{genre_id}') RETURNING id;").map {|result| result['id']}[0]
  end

end