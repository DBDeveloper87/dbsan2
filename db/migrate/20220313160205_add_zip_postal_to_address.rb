class AddZipPostalToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :zippostal, :string
  end
end
