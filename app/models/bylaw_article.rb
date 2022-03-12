class BylawArticle < ApplicationRecord
  belongs_to :bylaw
  has_many :bylaw_article_sections
  has_many :bylaw_article_subsections, through: :bylaw_article_sections
end
