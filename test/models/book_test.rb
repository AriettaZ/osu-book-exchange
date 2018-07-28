require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "should have title" do
    @book = Book.new
    @book.author = "Author Name"
    assert_not @book.save, "Book saved without title."
    @book.title = "New Title"
    assert @book.save, "Book failed to save with title."
  end

  # Not all books from API have an author listed
  # test "should have author" do
  #   @book = Book.new
  #   @book.title = "New Title"
  #   assert_not @book.save, "Book saved without authors."
  #   @book.author = "Author Name"
  #   assert @book.save, "Book failed to save with authors."
  # end
end
