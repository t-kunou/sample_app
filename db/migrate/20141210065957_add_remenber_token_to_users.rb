class AddRemenberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remenber_token, :string
    add_index :users, :remenber_token
  end
end
