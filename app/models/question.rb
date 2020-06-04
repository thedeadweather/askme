class Question < ApplicationRecord
  TAG_REGEX = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashrelationships, dependent: :destroy
  has_many :hashtags, through: :hashrelationships

  validates :text, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }

  after_save :create_hashtag
  before_destroy :delete_hashtag

  def create_hashtag
    find_hashtags.each do |t|
      if Hashtag.where(text: t).blank?
        hashtags.create(text: t)
      elsif hashtags.where(text: t).blank?
        hashtags << Hashtag.find_by(text: t)
      end
    end
  end

  def delete_hashtag
    hashtags.each { |tag| tag.destroy unless tag.questions.many? }
  end

  private

  def find_hashtags
    (text.to_s.scan(TAG_REGEX) | answer.to_s.scan(TAG_REGEX)).map(&:downcase)
  end
end
