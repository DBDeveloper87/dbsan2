class CreateCampApplicationShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_shifts, id: :uuid do |t|
      t.text :shifts
      t.references :camp_application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
