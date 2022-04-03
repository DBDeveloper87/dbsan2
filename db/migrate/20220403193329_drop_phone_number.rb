class DropPhoneNumber < ActiveRecord::Migration[7.0]
  def change
    drop_table :phone_numbers
  end
end
