class CreateSurveySections < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_sections, id: :uuid do |t|
      t.string :title
      t.text :content
      t.integer :section_number
      t.references :survey, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
