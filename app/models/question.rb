class Question < ApplicationRecord
  belongs_to :user

  validates :text, :user, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }
end
