class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :address_type
      t.string :address_l1
      t.string :address_l2
      t.string :city

      t.timestamps
    end
  end
end
