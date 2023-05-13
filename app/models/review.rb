class Review < ApplicationRecord
  validates :author, presence: { message: "Le champ Auteur est obligatoire." }
  validates :content, presence: { message: "Le champ Contenu est obligatoire." }
end
