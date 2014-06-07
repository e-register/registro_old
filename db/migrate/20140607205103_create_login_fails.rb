class CreateLoginFails < ActiveRecord::Migration
  def change
    create_table :login_fails do |t|

      t.timestamps
    end
  end
end
