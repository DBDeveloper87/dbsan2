class AddRolesAndTosToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :tos, :boolean
    add_column :users, :tos_aggreed_at, :datetime
  end
end
