class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :unicode_flag
      t.string :country_code
      t.string :name

      t.timestamps
    end
  end
end
