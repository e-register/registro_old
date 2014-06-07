class CreateClassTests < ActiveRecord::Migration
  def change
    create_table :class_tests do |t|

      t.timestamps
    end
  end
end
