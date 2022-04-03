class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :camp_application_pi, foreign_key: true, type: :uuid
      #t.references :camp_application_emergency, foreign_key: true, type: :uuid
      t.string :phone_type
      t.string :phone_number
      t.text :service_type
      #t.references :country, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
