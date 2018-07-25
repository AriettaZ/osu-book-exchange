class Book < ApplicationRecord
  has_many :posts
  has_many :authors
  accepts_nested_attributes_for :posts
  accepts_nested_attributes_for :authors
  searchable do
  	text :title
  	text :edition
  	text :ISBN_13
  	text :ISBN_10
  end
end
