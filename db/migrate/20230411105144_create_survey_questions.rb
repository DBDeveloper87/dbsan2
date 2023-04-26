class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions, id: :uuid do |t|
      t.references :survey_section, null: false, foreign_key: true, type: :uuid
      t.integer :position
      t.integer :question_type
      t.string :title
      t.text :description
      t.boolean :requiret
      t.boolean :conditionally_hidden

      t.timestamps
    end
  end
end
