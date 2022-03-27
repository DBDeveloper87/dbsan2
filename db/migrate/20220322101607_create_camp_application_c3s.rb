class CreateCampApplicationC3s < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_c3s, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.boolean :agree

      t.timestamps
    end
  end
end
