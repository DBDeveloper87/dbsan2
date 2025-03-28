class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.text :description
      t.references :product_category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
