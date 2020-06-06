class Hashtag < ApplicationRecord
  TAG_REGEX = /#[[:word:]-]+/

  has_many :hashtagquestions, dependent: :destroy
  has_many :questions, through: :hashtagquestions

  validates :text, presence: true, uniqueness: true

  before_validation :downcase_letters!

  private

  def downcase_letters!
    self.text&.downcase!
  end

end
