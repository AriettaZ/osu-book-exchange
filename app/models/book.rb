class Book < ApplicationRecord
  has_many :posts
  accepts_nested_attributes_for :posts
  searchable do
  	text :title
  	text :edition
  	text :ISBN_13
  	text :ISBN_10
  end
end
