class CleanUpAddress < ActiveRecord::Migration[7.0]
  def change
    remove_reference :addresses, :country, index: true, foreign_key:true, type: :uuid
    add_reference :addresses, :county, index: true, foreign_key:true, type: :uuid
    add_column :addresses, :zip4code, :string
    change_column_null :addresses, :profile_id, true
    change_column_null :addresses, :camp_application_pi_id, true
  end
end
