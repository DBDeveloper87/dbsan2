class AddAppReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :camp_application_pi, null: false, foreign_key: true, type: :uuid
  end
end
