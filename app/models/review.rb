class Review < ApplicationRecord
  validates :author, :content, presence: true
end
