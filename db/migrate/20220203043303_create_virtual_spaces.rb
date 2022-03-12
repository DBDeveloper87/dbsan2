class CreateVirtualSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :virtual_spaces, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
