class AddSpeakerSlotToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :speaker_slot, :integer, null: false, default: 1
  end
end
