require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  # setup runs before every single test
  setup do
    @bookmark = Bookmark.new
  end

  test "should belong to user" do
    @bookmark.post = Post.new
    @bookmark.favorite = false
    assert_not @bookmark.save, "Bookmark saved without user."
  end

  test "should belong to post" do
    @bookmark.user = User.new
    @bookmark.favorite = false
    assert_not @bookmark.save, "Bookmark saved without post."
  end

  test "should have a boolean favorite" do
    @bookmark.user = User.new
    @bookmark.post = Post.new
    assert_not @bookmark.save, "Bookmark saved without fav bool."
    @bookmark.favorite = false
    assert @bookmark.save, "Bookmark coundn't save with fav false."
    @bookmark.favorite = true
    assert @bookmark.save, "Bookmark coundn't save with fav true."
  end

  test "bookmark should be unique" do
    user = User.create(name: "Channing Jacobs", email: "e@m", password: "123456")
    book = Book.create(title: "My Title", ISBN_13: "978-3-16-148410-0", edition: "1st")
    post = Post.create(user: user, price: 0, post_type: "offer", book: book)
    @bookmark = Bookmark.new(user: user, post: post, favorite: true)
    assert @bookmark.valid?, @bookmark.errors.full_messages
    bookmark_dup = @bookmark.dup
    assert bookmark_dup.valid?, "Duplicated bookmark isn't valid."
    @bookmark.save
    assert_not bookmark_dup.save, "Duplicated bookmark was saved."
  end

end
