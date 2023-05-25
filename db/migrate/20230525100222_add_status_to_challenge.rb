class AddStatusToChallenge < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :status, :integer
  end
end
