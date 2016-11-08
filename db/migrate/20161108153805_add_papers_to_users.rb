class AddPapersToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :papers, :user, foreign_key: true
  end
end
