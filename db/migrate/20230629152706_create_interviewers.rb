class CreateInterviewers < ActiveRecord::Migration[7.0]
  def change
    create_table :interviewers, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_reference :survey_responses, :interviewer, foreign_key: true, type: :uuid

  end
end
