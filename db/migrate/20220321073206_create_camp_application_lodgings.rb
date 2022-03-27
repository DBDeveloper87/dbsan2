class CreateCampApplicationLodgings < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_lodgings, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.boolean :on_premises
      t.boolean :share_smoker
      t.boolean :difficulty_walking
      t.boolean :difficulty_stairs
      t.boolean :service_animal
      t.boolean :share_service_animal
      t.text :mobility_aids
      t.boolean :medical_device_charging

      t.timestamps
    end
  end
end
