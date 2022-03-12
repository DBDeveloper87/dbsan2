class CreateStateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :state_provinces, id: :uuid do |t|
      t.string :unicode_flag
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
