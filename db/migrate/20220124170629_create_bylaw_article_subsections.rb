class CreateBylawArticleSubsections < ActiveRecord::Migration[7.0]
  def change
    create_table :bylaw_article_subsections, id: :uuid do |t|
      t.integer :subsec_num
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
