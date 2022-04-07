class AddColumnsToCampApplicationLodging < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_application_lodgings, :tent_or_cabin, :string
    add_column :camp_application_lodgings, :bring_tent, :boolean
    add_column :camp_application_lodgings, :share_with, :text
  end
end
