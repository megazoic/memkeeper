class AddTagIdToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :tag_id, :integer
  end
end
