class AddOutlineToPaper < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :outline, :text
  end
end
