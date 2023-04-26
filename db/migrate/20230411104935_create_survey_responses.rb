class CreateSurveyResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_responses, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.float :score
      t.boolean :informed_consent
      t.integer :status

      t.timestamps
    end
  end
end
