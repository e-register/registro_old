# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140608185649) do

  create_table "class_infos", force: true do |t|
    t.string  "name"
    t.string  "specialization"
    t.integer "year"
    t.integer "admin_id"
  end

  create_table "class_tests", force: true do |t|
    t.string "description", limit: 500
  end

  create_table "credentials", force: true do |t|
    t.string  "username"
    t.string  "password"
    t.integer "user_id"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.date     "date"
    t.integer  "score_id"
    t.integer  "subject_id"
    t.integer  "evaluation_type"
    t.string   "description"
    t.integer  "class_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_fails", force: true do |t|
    t.string   "username"
    t.string   "ip",         limit: 15
    t.datetime "created_on"
  end

  create_table "scores", force: true do |t|
    t.string "text",  limit: 10
    t.float  "value"
  end

  create_table "students", id: false, force: true do |t|
    t.integer "student_id"
    t.integer "class_info_id"
  end

  add_index "students", ["student_id", "class_info_id"], name: "index_students_on_student_id_and_class_info_id", unique: true, using: :btree

  create_table "subjects", force: true do |t|
    t.string "name",        limit: 20
    t.string "description"
  end

  create_table "teachers", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "subject_id"
    t.integer "class_info_id"
  end

  add_index "teachers", ["user_id", "subject_id", "class_info_id"], name: "index_teachers_on_user_id_and_subject_id_and_class_info_id", unique: true, using: :btree

  create_table "tokens", force: true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_on"
    t.datetime "expire_on"
  end

  add_index "tokens", ["token"], name: "index_tokens_on_token", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "surname"
    t.date    "born_date"
    t.string  "born_city"
    t.integer "gender"
  end

end
