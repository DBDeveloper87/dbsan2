class AddBoolToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :virtual_space, :boolean, null: false, default: false
    add_column :events, :in_person, :boolean, null: false, default: false
    add_column :events, :registration_required, :boolean, null: false, default: false
  end
end
