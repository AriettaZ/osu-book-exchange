class Book < ApplicationRecord
  has_many :posts

  searchable do
  	text :title
  	text :edition
  	text :isbn13
  	text :isbn10
  end
end
