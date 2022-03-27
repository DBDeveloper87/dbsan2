class CreateCampApplicationMatchings < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_matchings, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.text :work_with_type
      t.string :height
      t.string :describe_self
      t.text :activity_type

      t.timestamps
    end
  end
end
