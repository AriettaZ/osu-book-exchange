require 'test_helper'

class BookTest < ActiveSupport::TestCase
  #book model has no validations
  test "should have title" do
    @book = Book.new
    assert_not @book.save, "Book saved without title."
    @book.title = "New title"
    assert @book.save, "Book failed to save with title."
  end
end
