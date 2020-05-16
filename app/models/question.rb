class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :text, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }
end
