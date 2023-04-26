class AddColumnsToSurvey < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :long_description, :text
    add_column :surveys, :required_states, :text
    add_column :surveys, :required_counties, :text
    add_column :surveys, :status, :integer
    add_column :surveys, :response_open, :datetime
    add_column :surveys, :response_close, :datetime
    add_column :surveys, :require_informed_consent, :boolean
    add_column :surveys, :informed_consent, :text
    add_column :surveys, :exit_message, :text
    add_column :surveys, :slug, :string
  end
end
