class VirtualSpace < ApplicationRecord
  belongs_to :event
  has_many :zoom_meetings
  
end
