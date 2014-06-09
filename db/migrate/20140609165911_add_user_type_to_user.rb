class AddUserTypeToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.integer :user_type
  	end
  end
end
