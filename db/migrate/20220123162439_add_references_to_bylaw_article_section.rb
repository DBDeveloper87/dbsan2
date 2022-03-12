class AddReferencesToBylawArticleSection < ActiveRecord::Migration[7.0]
  def change
    add_reference :bylaw_article_sections, :bylaw_article, null: false, foreign_key: true, type: :uuid
  end
end
