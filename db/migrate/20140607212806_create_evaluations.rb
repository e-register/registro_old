class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|

      t.timestamps
    end
  end
end
