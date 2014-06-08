class RemovedSaltFromCredentials < ActiveRecord::Migration
  def change
  	change_table :credentials do |t|
  		t.remove :salt
  	end
  end
end
