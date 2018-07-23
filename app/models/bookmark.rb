class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :favorite, inclusion: {in: [true, false]}
end
