class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :body
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
