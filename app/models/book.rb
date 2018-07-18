class Book < ApplicationRecord
  has_many :posts
  extend FriendlyId
  friendly_id :title, use: :slugged
end
