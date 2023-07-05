class ChannelMember < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  enum role: {subscriber: 0,
              free_member: 1,
              paid_member: 2,
              associate: 3,
              staff: 4
              }
  
  def first_name
    self.user.profile.first_name
  end

  def last_name
    self.user.profile.last_name
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
