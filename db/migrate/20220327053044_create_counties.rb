class CreateCounties < ActiveRecord::Migration[7.0]
  def change
    create_table :counties, id: :uuid do |t|
      t.references :state_province, null: false, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
  end
end
