class AddTimestampsToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :created_at, :datetime
    add_column :papers, :updated_at, :datetime
  end
end
