class CreateCampApplicationBis < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_bis, id: :uuid do |t|
      t.text :about_you
      t.text :past_camps
      t.text :active_community
      t.text :interests
      t.text :other_comments
      t.references :camp_application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
