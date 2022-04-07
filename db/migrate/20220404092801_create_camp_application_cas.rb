class CreateCampApplicationCas < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_cas, id: :uuid do |t|
      t.string :sign_language
      t.string :tactile
      t.string :pt
      t.references :camp_application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
