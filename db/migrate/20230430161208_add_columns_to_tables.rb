class AddColumnsToTables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :survey_responses, :user_id, true
    add_column :surveys, :survey_type, :integer
    add_column :survey_sections, :conditionally_hidden, :boolean
    add_column :survey_responses, :first_name, :string
    add_column :survey_responses, :last_name, :string
    add_column :survey_responses, :email_address, :string
    add_column :survey_responses, :include_sections, :text
    add_column :question_options, :rating_value, :integer
    
    create_table :question_options_response_answers, id: false do |t|
      t.references :question_option, type: :uuid, foreign_key: true
      t.references :response_answer, type: :uuid, foreigh_key: true
    end
  end
end
