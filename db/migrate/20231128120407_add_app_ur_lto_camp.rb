class AddAppUrLtoCamp < ActiveRecord::Migration[7.0]
  def change
    add_column :camps, :app_url, :string
  end
end
