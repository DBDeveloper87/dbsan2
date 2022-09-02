class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :photos, id: :uuid do |t|
      t.string :label
      t.string :image_type
      t.string :alt_text
      t.text :description
      t.references :product_image_set, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
