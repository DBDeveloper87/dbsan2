class AddReferenceToCampApplication < ActiveRecord::Migration[7.0]
  def change
    add_reference :camp_applications, :camp_application_type, foreign_key: true, type: :uuid
  end
end
