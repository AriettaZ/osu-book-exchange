class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :favorite, presence: true
end
