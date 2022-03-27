class CreateCampApplicationMedicals < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_medicals, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.boolean :medical_policy
      t.boolean :bring_assistant
      t.boolean :smoke
      t.text :medical_conditions
      t.text :other_health
      t.text :medical_allergies

      t.timestamps
    end
  end
end
