class AddUniqueIndexToUsername < ActiveRecord::Migration
  def change
  	add_index :credentials, :username, unique: true
  end
end
