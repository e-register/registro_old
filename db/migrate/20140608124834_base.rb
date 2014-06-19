class Base < ActiveRecord::Migration
  def change
  	create_table :users, force: true do |t|
  		t.string  :name, limit: 50
  		t.string  :surname, limit: 50
  		t.date    :born_date
  		t.string  :born_city
  		t.integer :gender
  	end

  	create_table :credentials, force: true do |t|
  		t.string  :username
  		t.string  :password
  		t.string  :salt
  		t.belongs_to :user
  	end

  	create_table :tokens, force: true do |t|
  		t.string  :token
  		t.belongs_to :user
  		t.datetime :created_on
  		t.datetime :expire_on
  	end
  	add_index :tokens, :token, unique: true

  	create_table :login_fails, force: true do |t|
  		t.string :username
  		t.string :ip, limit: 15
  		t.datetime :created_on
  	end

  	create_table :class_infos, force: true do |t|
  		t.string :name
  		t.string :specialization
  		t.integer :year
  		t.belongs_to :admin, as: :user
  	end

  	create_table :students, force: true do |t|
		t.belongs_to :student, as: :user
		t.belongs_to :class_info
  	end
  	add_index :students, [:student_id, :class_info_id], unique: true

  	create_table :subjects, force: true do |t|
  		t.string :name, limit: 20
  		t.string :description
  	end

  	create_table :teachers, force: true do |t|
		t.belongs_to :teacher
		t.belongs_to :subject
		t.belongs_to :class_info
  	end
  	add_index :teachers, [:teacher_id, :subject_id, :class_info_id], unique: true

  	create_table :scores, force: true do |t|
  		t.string :text, limit: 10
  		t.float :value
  	end

	create_table :class_tests, force: true do |t|
  		t.string :description, limit: 500
  	end

  	create_table :evaluations, force: true do |t|
  		t.belongs_to :teacher, as: :user
  		t.belongs_to :student, as: :user
  		t.date :date
  		t.belongs_to :score
  		t.belongs_to :subject
  		t.integer :type
  		t.string :description
  		t.belongs_to :class_test
  		t.timestamps
  	end

  end
end
