class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :encryptable

  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :event_attendees
  has_many :events, through: :event_attendees
  
  
end
