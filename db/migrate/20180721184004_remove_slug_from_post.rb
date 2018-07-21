class RemoveSlugFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :slug, :string
    remove_column :books, :slug, :string
    remove_column :users, :slug, :string
    drop_table :friendly_id_slugs
  end
end
