class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :channel, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
