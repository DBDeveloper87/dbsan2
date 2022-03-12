class CreateBylawArticleSections < ActiveRecord::Migration[7.0]
  def change
    create_table :bylaw_article_sections, id: :uuid do |t|
      t.integer :sec_num
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
