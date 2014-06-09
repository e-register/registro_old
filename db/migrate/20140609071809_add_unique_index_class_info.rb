class AddUniqueIndexClassInfo < ActiveRecord::Migration
  def change
    add_index :class_infos, [ :name, :specialization ], unique: true
  end
end
