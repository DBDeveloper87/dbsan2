class AddCostToCampApplicationType < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_application_types, :cost, :integer
  end
end
