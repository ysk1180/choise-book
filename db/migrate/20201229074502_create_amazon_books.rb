class CreateAmazonBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :amazon_books do |t|
      t.string :isbn, null: false
      t.string :title
      t.integer :page_count
      t.string :image_url
      t.float :review_score
      t.integer :review_count
      t.string :link

      t.timestamps
    end

    add_index :amazon_books, :isbn, unique: true
  end
end
