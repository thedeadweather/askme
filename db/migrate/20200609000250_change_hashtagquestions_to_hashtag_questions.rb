class ChangeHashtagquestionsToHashtagQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_table :hashtagquestions, :hashtag_questions
  end
end
