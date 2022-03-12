class AddReferenceToBylawArticleSubsection < ActiveRecord::Migration[7.0]
  def change
    add_reference :bylaw_article_subsections, :bylaw_article_section, null: false, foreign_key: true, type: :uuid
    add_reference :bylaw_article_subsections, :bylaw_article, null: false, foreign_key: true, type: :uuid
  end
end
