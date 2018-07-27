class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, index: true
      t.references :receiver, index: true
      t.timestamps
    end
  end
end
