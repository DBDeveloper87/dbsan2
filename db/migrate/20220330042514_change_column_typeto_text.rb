class ChangeColumnTypetoText < ActiveRecord::Migration[7.0]
  def change
    change_column :camp_application_pis, :gender, :text
  end
end
