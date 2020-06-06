class ChangeHashrelationshipToHashtagQuestion < ActiveRecord::Migration[6.0]
  def change
    rename_table :hashrelationships, :hashtagquestions
  end
end
