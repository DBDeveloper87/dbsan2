class CreateCampApplicationPis < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_pis, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.text :pronouns
      t.date :dob

      t.timestamps
    end
  end
end
