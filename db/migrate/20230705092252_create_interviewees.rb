class CreateInterviewees < ActiveRecord::Migration[7.0]
  def change
    create_table :interviewees, id: :uuid do |t|
      t.references :survey_response, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :county

      t.timestamps
    end
  end
end
