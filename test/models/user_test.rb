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
end
