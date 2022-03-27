class CreateCampApplicationCovids < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_covids, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.boolean :vaccinated
      t.timestamps
    end
  end
end
