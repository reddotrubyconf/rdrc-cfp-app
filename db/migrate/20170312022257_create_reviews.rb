class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :paper

      t.integer :score, null: false
      t.text :comments

      t.timestamps
    end
  end
end
