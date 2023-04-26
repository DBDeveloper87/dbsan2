class CreateQuestionOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_options, id: :uuid do |t|
      t.references :survey_question, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.integer :logic
      t.text :sub_logic

      t.timestamps
    end
  end
end
