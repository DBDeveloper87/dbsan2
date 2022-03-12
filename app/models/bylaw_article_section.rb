class BylawArticleSection < ApplicationRecord
	belongs_to :bylaw_article
	has_many :bylaw_article_subsections
end
