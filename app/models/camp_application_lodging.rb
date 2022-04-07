class CampApplicationLodging < ApplicationRecord
  belongs_to :camp_application

  serialize :share_with
end
