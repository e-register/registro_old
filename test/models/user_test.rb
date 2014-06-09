require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "All information correct for edoardo" do
		user = User.where(name: "Edoardo", surname: "Morassutto").first
		
		assert_not_nil user
		
		assert_equal "Edoardo", user.name
		assert_equal "Morassutto", user.surname
		assert_equal Date.parse("1997-01-07"), user.born_date
		assert_equal "Pordenone", user.born_city
		assert_equal "male", user.gender
		
	end
	
	test "All information correct for prof" do
		user = User.where(name: "Anna", surname: "Rossi").first
		
		assert_not_nil user
		
		assert_equal "Anna", user.name
		assert_equal "Rossi", user.surname
		assert_equal Date.parse("1950-01-01"), user.born_date
		assert_equal "Roma", user.born_city
		assert_equal "female", user.gender
		
	end
	
	test "New token works" do
		user = Credential.check username: "edoardo", password: "password"
		token = user.get_new_token
		
		t = Token.where(token: token.token).first
		
		assert_not_nil t
		
		assert_equal token.token, t.token
		assert_equal user, t.user
		assert_equal token, t
	end
end
