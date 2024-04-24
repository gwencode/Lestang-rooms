class UrlPicture < ApplicationRecord
  has_one_attached :photo

  validates :name, :page, :description, :url, presence: true
  validates :name, uniqueness: { scope: :page }
end
