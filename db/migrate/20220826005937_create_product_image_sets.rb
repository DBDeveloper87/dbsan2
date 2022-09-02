class CreateProductImageSets < ActiveRecord::Migration[7.0]
  def change
    create_table :product_image_sets, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.string :label
      t.boolean :default

      t.timestamps
    end
  end
end
