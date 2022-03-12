class CreateBylawArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :bylaw_articles, id: :uuid do |t|
      t.string :roman_numeral
      t.string :title
      t.text :introduction
      t.references :bylaw, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
