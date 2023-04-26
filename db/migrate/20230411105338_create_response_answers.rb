class CreateResponseAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :response_answers, id: :uuid do |t|
      t.references :survey_response, null: false, foreign_key: true, type: :uuid
      t.references :survey_question, null: false, foreign_key: true, type: :uuid
      t.text :long_answer

      t.timestamps
    end
  end
end
