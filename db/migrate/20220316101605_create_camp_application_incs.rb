class CreateCampApplicationIncs < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_incs, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.text :identity
      t.text :communication_pref
      t.text :receiv_signs
      t.text :dominant_hand

      t.timestamps
    end
  end
end
