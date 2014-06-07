class CreateClassInfos < ActiveRecord::Migration
  def change
    create_table :class_infos do |t|

      t.timestamps
    end
  end
end
