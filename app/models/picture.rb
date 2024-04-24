class Picture < ApplicationRecord
  has_many_attached :photos

  validates :name, presence: true, uniqueness: { scope: :page }
  validates :photos, :description, :page, presence: true
end
