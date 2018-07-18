class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :actual_product_image

      t.timestamps
    end
  end
end
