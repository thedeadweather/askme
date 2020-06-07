class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtagquestions, dependent: :destroy
  has_many :hashtags, through: :hashtagquestions

  validates :text, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }

  after_commit :create_hashtag, on: %i[create update]
  after_commit :delete_hashtag, on: :destroy

  def create_hashtag
    find_hashtags.each do |t|
      tag = Hashtag.find_or_create_by(text: t)
      hashtags << tag unless hashtags.include?(tag)
    end
  end

  def delete_hashtag
    Hashtag.left_joins(:hashtagquestions).where(hashtagquestions: {hashtag_id: nil}).destroy_all
  end

  private

  def find_hashtags
    (text.to_s.scan(Hashtag::TAG_REGEX) | answer.to_s.scan(Hashtag::TAG_REGEX)).map(&:downcase)
  end
end
