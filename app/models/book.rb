class Book < ApplicationRecord
  has_many :posts
  extend FriendlyId
  friendly_id :title, use: :slugged

  searchable do
  	text :title
  	text :edition
  	text :isbn13
  	text :isbn10
  end
end
