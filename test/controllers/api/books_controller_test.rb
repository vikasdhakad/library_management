require "test_helper"

class Api::BooksControllerTest < ActionDispatch::IntegrationTest
  test "Books Info Success" do
    user = create_and_fetch_user
    library = create_and_fetch_library
    create_and_assign_books(library, user)
    books = get("/api/books/#{library.id}/details")
    body = JSON.parse(response.body)['body']
    status = body.include?({"book_name"=>"Cosmos", "book_status"=>"available"}) &&
             body.include?({"book_name"=>"Journals", "book_status"=>"available"}) &&
             body.include?({"book_name"=>"Demon-Haunted World", "book_status"=>"checkout", "checked_out_user"=>"Vikas"})
    assert status
  end

  def teardown
    return puts "Books Info tests passed successfully!" if passed?

    puts "Books Info tests failed."
  end

  private

  def create_and_fetch_user
    User.create(email: 'vikas@user.com', name: 'Vikas', password: 'Vg6@%rgfd45sfd')
  end

  def create_and_fetch_library
    Library.create(name: "Science Library", books_limit: 5)
  end

  def create_and_assign_books(library, user)
    library.books.create(name: "Cosmos")
    library.books.create(name: "Journals")
    book = library.books.create(name: "Demon-Haunted World")
    book.assign_user(user)
  end
end
