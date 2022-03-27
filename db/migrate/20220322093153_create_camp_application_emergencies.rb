class CreateCampApplicationEmergencies < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_emergencies, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.string :contact_full_name
      t.string :contact_relationship

      t.timestamps
    end
  end
end
