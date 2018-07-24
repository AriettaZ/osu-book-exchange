class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :favorite, inclusion: {in: [true, false]}
  # Only allow one bookmark per post
  validates_uniqueness_of :user_id, :scope => [:post_id]
end
