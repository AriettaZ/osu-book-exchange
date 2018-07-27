class Image < ApplicationRecord
  belongs_to :post
  mount_uploader :actual_product_image, BookImageUploader
end
