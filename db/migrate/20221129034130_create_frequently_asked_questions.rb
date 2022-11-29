class CreateFrequentlyAskedQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :frequently_asked_questions, id: :uuid do |t|
      t.references :challenge, null: false, foreign_key: true, type: :uuid
      t.string :question_group
      t.string :question
      t.text :answer
      t.integer :question_number
      t.integer :group_number
      t.timestamps
    end
  end
end
