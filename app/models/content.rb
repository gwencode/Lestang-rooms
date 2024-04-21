class Content < ApplicationRecord
  has_rich_text :html

  validates :name, presence: true, uniqueness: true
  validates :html, presence: { message: "doit être renseigné" }
end
