class CreateCampApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_applications, id: :uuid do |t|
      t.references :camp, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid, unique: true
      t.string :status, null: false, default: "New Application -- In Progress"
      t.timestamps
    end
  end
end
