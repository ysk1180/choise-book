class CreateSearchWords < ActiveRecord::Migration[6.1]
  def change
    create_table :search_words do |t|
      t.string :word, null: false

      t.timestamps
    end

    add_index :search_words, :word
  end
end
