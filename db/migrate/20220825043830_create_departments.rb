class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments, id: :uuid do |t|
      t.string :name
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
