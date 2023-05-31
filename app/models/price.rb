class Price < ApplicationRecord
  belongs_to :challenge, optional: true
  has_many :challenge_participants
  has_one_attached :shirt_image

  serialize :perks
  before_validation :reject_blanks

  validates :name, presence: true
  
  private
    def reject_blanks
      self.perks = self.perks.compact_blank
    end
end
