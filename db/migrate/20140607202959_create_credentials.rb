class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|

      t.timestamps
    end
  end
end
