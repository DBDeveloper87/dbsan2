class AddReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :state_province, null: false, foreign_key: true, type: :uuid
    add_reference :addresses, :country, null: false, foreign_key: true, type: :uuid
  end
end
