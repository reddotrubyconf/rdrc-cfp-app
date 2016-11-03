class CreatePapers < ActiveRecord::Migration[5.0]
  def change
    create_table :papers do |t|
      t.string :title, null: false
      t.text :abstract, null: false
      t.integer :status, null: false, default: 1
    end
  end
end
