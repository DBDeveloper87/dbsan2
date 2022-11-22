class AddDeciToDonation < ActiveRecord::Migration[7.0]
  def change
    add_column :donations, :amount_deci, :float
  end
end
