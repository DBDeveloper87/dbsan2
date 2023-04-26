class ChannelMenu < ApplicationRecord
  belongs_to :channel
  has_many :channel_menu_items
end
