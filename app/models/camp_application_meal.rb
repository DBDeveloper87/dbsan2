class CampApplicationMeal < ApplicationRecord
  belongs_to :camp_application

  serialize :dietary_lifestyle
  serialize :allergens
end
