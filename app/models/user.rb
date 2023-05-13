class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages

  validates :first_name, :last_name, :email, presence: true
end
