class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories, id: :uuid do |t|
      t.string :name
      t.string :slug, unique: true
      t.references :department, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
