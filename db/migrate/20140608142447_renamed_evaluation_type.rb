class RenamedEvaluationType < ActiveRecord::Migration
  def change
  	change_table :evaluations do |t|
  		t.rename :type, :evaluation_type
  	end
  end
end
