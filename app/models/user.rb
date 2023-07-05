class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :encryptable

  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :channel_owners
  has_many :channel_members
  accepts_nested_attributes_for :channel_members
  has_many :channels, through: :channel_members
  has_many :interviewers
  has_many :event_attendees
  has_many :events, through: :event_attendees
  has_many :camp_applications
  has_many :camps, through: :camp_applications
  has_many :phone_numbers
  has_many :challenge_participants
  has_many :challenges, through: :challenge_participants
  has_many :donations
  
end
