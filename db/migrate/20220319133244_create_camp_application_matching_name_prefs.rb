class CreateCampApplicationMatchingNamePrefs < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_matchnps, id: :uuid do |t|
      t.references :camp_application_matching, null: false, foreign_key: true, type: :uuid
      t.string :name_type
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
