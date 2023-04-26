class SocialNetwork < ApplicationRecord
	belongs_to :channel, optional: true
end
