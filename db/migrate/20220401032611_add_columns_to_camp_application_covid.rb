class AddColumnsToCampApplicationCovid < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_application_covids, :vaccination_type, :text
    add_column :camp_application_covids, :first_shot, :date
    add_column :camp_application_covids, :second_shot, :date
    add_column :camp_application_covids, :booster_shot, :date
  end
end
