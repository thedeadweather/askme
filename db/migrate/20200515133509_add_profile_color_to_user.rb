class AddProfileColorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_color, :color
  end
end
