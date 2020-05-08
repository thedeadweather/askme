class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }
end
