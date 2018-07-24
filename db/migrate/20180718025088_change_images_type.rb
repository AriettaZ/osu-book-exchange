class ChangeImagesType < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :actual_product_image, :text
  end
end
