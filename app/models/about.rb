class About < ApplicationRecord
	scope :filter_by_published, -> (published) { where published: published }
end
