class ChangeColorToBeStringInUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :profile_color, :string
  end
end
