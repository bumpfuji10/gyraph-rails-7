class AddProfileAndIconToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :text
    add_column :users, :icon, :string
  end
end
