require 'test_helper'

class UsersHelperTest < ActionView::TestCase
	include UsersHelper

	test "Get myself info" do
		edoardo = users(:user_edoardo)

		r = get_user_info edoardo, edoardo

		assert_not_nil r

		aspected = {
			name: edoardo.name,
			surname: edoardo.surname,
			user_type: edoardo.user_type,
			born_date: edoardo.born_date,
			born_city: edoardo.born_city,
			gender: edoardo.gender,
			classes: edoardo.classes
		}

		assert_equal aspected, r
	end

	test "Get stranger info" do
		edoardo = users(:user_edoardo)
		stranger = users(:user_stranger)

		r = get_user_info edoardo, stranger

		aspected = {}

		assert_not_nil r

		assert_equal aspected, r
	end

	test "Edit valid info" do
		admin = users(:user_admin)
		edoardo = users(:user_edoardo)

		r = get_edit_info admin, edoardo

		aspected = [ :name, :surname, :born_date, :born_city, :gender, :user_type ]

		assert_equal aspected, r
	end

	test "Edit not valid info" do
		elia = users(:user_elia)
		edoardo = users(:user_edoardo)

		r = get_edit_info elia, edoardo

		aspected = []

		assert_equal aspected, r
	end

	test "Create allowed" do
		admin = users(:user_admin)

		r = get_new_info admin

		assert_not_nil r
		assert r[:create]
	end

	test "Create not allowed" do
		edoardo = users(:user_edoardo)

		r = get_new_info edoardo

		assert_not_nil r
		assert_not r[:create]
	end

end
