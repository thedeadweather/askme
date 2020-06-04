class Hashtag < ApplicationRecord
  has_many :hashrelationships, dependent: :destroy
  has_many :questions, through: :hashrelationships

  validates :text, presence: true, uniqueness: true

  before_validation :downcase_letters!

  private

  def downcase_letters!
    self.text&.downcase!
  end

end
