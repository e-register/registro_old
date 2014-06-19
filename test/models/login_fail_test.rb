require 'test_helper'

class LoginFailTest < ActiveSupport::TestCase
  test "login fails log" do
  	username = rand(36**15).to_s(36)
  	ip = [rand(256),rand(256),rand(256),rand(256)].join('.')

  	res = LoginFail.bad_password(ip, username: username, password: "password")
  	assert res

  	l = LoginFail.where(username: username).first
  	assert_not_nil l
  	assert_equal username, l.username
  	assert_not_nil l.ip
  	assert_equal ip, l.ip
  end
end
