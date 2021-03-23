class AddTimestampToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :ts, :datetime
  end
end
