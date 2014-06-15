require 'test_helper'

class PagesHelperTest < ActionView::TestCase
	test "Get type guest" do
		assert_equal :guest, get_user_type(nil)
	end
	
	test "Get type student" do
		edoardo = users(:user_edoardo)
		assert_equal :student, get_user_type(edoardo.id)
	end
	
	test "Get type teacher" do
		prof = users(:user_prof)
		assert_equal :teacher, get_user_type(prof.id)
	end
	
	test "Get type admin" do
		admin = users(:user_admin)
		assert_equal :admin, get_user_type(admin.id)
	end
end
