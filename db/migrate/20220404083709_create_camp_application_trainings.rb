class CreateCampApplicationTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_trainings, id: :uuid do |t|
      t.boolean :available
      t.text :training_history
      t.references :camp_application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
