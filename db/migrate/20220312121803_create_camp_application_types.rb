class CreateCampApplicationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_types, id: :uuid do |t|
      t.string :kind
      t.text :description
      t.references :camp, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
