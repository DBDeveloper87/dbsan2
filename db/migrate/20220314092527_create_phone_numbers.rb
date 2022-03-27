class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers, id: :uuid do |t|
      t.string :phone_type
      t.string :phone_number
      t.string :service_type
      t.references :camp_application_pi, null: false, foreign_key: true, type: :uuid
      t.references :profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
