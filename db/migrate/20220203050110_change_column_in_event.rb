class ChangeColumnInEvent < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :virtual_space, :has_virtual_space
  end
end
