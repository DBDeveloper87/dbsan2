class CreateBylaws < ActiveRecord::Migration[7.0]
  def change
    create_table :bylaws, id: :uuid do |t|
      t.string :title, null: false
      t.text :introduction, null: false
      t.string :status, null: false, default: "Draft"
      t.datetime :proposed
      t.datetime :approved
      t.boolean :current, null: false, default: false

      t.timestamps
    end
  end
end
