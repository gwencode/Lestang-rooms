class Review < ApplicationRecord
  # validates :author, presence: { message: "Le champ Auteur doit être rempli." }
  # validates :content, presence: { message: "Le champ Contenu doit être rempli." }
  validates :author, :content, presence: true
end
