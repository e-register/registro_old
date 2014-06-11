require 'test_helper'

class UsersHelperTest < ActionView::TestCase
	include UsersHelper

	test "Get myself info" do
		edoardo = users(:user_edoardo)
		
		r = get_user_info edoardo, edoardo
				
		assert_not_nil r
		
		assert_equal edoardo.name, r[:name]
		assert_equal edoardo.surname, r[:surname]
		assert_equal edoardo.user_type, r[:user_type]
		assert_equal edoardo.classes, r[:classes]
	end
	
	test "Get stranger info" do
		edoardo = users(:user_edoardo)
		stranger = users(:user_stranger)
		
		r = get_user_info edoardo, stranger
		
		aspected = {
			name: stranger.name,
			surname: stranger.surname,
			user_type: stranger.user_type
		}
		
		assert_not_nil r
		
		assert_equal aspected, r
	end
	
	test "Edit valid info" do
		admin = users(:user_admin)
		edoardo = users(:user_edoardo)
		
		r = get_edit_info admin, edoardo
		
		aspected = [ :name, :surname, :user_type ]
		
		assert_equal aspected, r
	end
	
	test "Edit not valid info" do
		elia = users(:user_elia)
		edoardo = users(:user_edoardo)
		
		r = get_edit_info elia, edoardo
		
		aspected = []
		
		assert_equal aspected, r
	end
	
end
