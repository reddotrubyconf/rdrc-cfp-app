class AddScrubbedOutlineToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :scrubbed_outline, :text
  end
end
