require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "All information correct for edoardo" do
		u1 = users(:user_edoardo)
		u2 = User.find u1.id
		
		assert_not_nil u2
		
		assert_equal u1.name, u2.name
		assert_equal u1.surname, u2.surname
		assert_equal u1.born_date, u2.born_date
		assert_equal u1.born_city, u2.born_city
		assert_equal u1.gender, u2.gender
		
	end
	
	test "New token works" do
		user = users(:user_edoardo)
		token = user.get_new_token
		
		t = Token.where(token: token.token).first
		
		assert_not_nil t
		
		assert_equal token.token, t.token
		assert_equal user, t.user
		assert_equal token, t
	end
	
	test "Get student classes" do
		elia = users(:user_elia)
		
		c = elia.classes
		
		assert_equal [class_infos(:class_1)], c
	end
	
	test "Get prof classes" do
		prof = users(:user_prof)
		
		c = prof.classes
		
		assert_equal [class_infos(:class_1)], c
	end
	
	test "Check mutual class" do
		edoardo = users(:user_edoardo)
		prof = users(:user_prof)
		
		assert edoardo.same_class? prof
		assert prof.same_class? edoardo	
	end
	
	test "Check admin class" do
		edoardo = users(:user_edoardo)
		prof = users(:user_prof)
		
		a = edoardo.admins
		
		assert_equal [prof], a
	end
	
	test "Check full name edoardo" do
		edoardo = users(:user_edoardo)
		
		assert_equal "Edoardo Morassutto", edoardo.full_name
	end
	
	test "Check full name admin" do
		admin = users(:user_admin)
		
		assert_equal "Administrator", admin.full_name
	end
end
