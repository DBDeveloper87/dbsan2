class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender_string
      t.string :pronouns
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
