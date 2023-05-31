class CreateChallengePricings < ActiveRecord::Migration[7.0]
  def change
    create_table :prices, id: :uuid do |t|
      t.string :name
      t.text :description
      t.float :price
      t.text :perks
      t.boolean :shirt
      t.text :shirt_description
      t.references :challenge, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
