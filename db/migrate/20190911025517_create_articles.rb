class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end
    add_index(:articles, :user_id)
    add_index(:articles, :category_id)
  end
end
