class Picture < ApplicationRecord
  has_many_attached :photos

  validates :name, presence: true, uniqueness: true
  validates :photos, :description, presence: true
end
