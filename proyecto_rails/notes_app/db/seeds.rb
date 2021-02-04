# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


10.times do |i|
    user = User.create! :email => "user#{i}@email.com" , :password => "userpw#{i}", :password_confirmation => "userpw#{i}"

    global_book = user.books.create(user_id: user.id, name:"Global Book")

    3.times do |j|
    global_book.notes.create(book_id: global_book.id, title: "Global Book Note #{j}" , content: "
# This is a title
## This is a Subtitle
List:
- Element list Nº 1
- Element list Nº 2")
    end

    5.times do |k|
        book = user.books.create(user_id: user.id, name:"Book #{k}")
        3.times do |n|
            book.notes.create(book_id: book.id, title: "Note #{n}", content: "
# This is a title
## This is a Subtitle
List:
- Element list Nº 1
- Element list Nº 2")
        end
    end
end