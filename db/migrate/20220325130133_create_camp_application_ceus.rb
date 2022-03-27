class CreateCampApplicationCeus < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_ceus, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.text :certifications

      t.timestamps
    end
  end
end
