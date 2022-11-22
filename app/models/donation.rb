class Donation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :challenge_participant, optional: true
  attribute :other_amount

  before_create :update_amount

  def update_amount
    if self.amount.nil?
      self.amount = (self.other_amount.to_i * 100).to_s
    end
  end

  def amount_deci
    self.amount.to_i / 100.0
  end

  
end
