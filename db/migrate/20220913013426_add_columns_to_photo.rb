class AddColumnsToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :exif, :text
  end
end
