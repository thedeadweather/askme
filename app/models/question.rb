class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, presence: true
  # проверка макс длины текста
  validates :text, length: { maximum: 255 }

  after_commit :delete_hashtag, on: %i[destroy update]
  after_commit :create_hashtag, on: %i[create update]

  def create_hashtag
    hashtag_questions.clear
    find_hashtags.each do |t|
      tag = Hashtag.find_or_create_by(text: t)
      hashtags << tag unless hashtags.include?(tag)
    end
  end

  def delete_hashtag
    Hashtag.left_joins(:hashtag_questions).
      where(hashtag_questions: {hashtag_id: nil}).destroy_all
  end

  private

  def find_hashtags
    "#{text} #{answer}".downcase.scan(Hashtag::TAG_REGEX).uniq
  end
end
