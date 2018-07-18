class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :type
      t.text :course_number
      t.decimal :price
      t.text :condition
      t.integer :payment_method
      t.text :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
