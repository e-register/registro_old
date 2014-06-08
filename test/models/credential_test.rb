require 'test_helper'

class CredentialTest < ActiveSupport::TestCase

  test "login as edoardo" do
  	edoardo = User.where(name: "Edoardo", surname: "Morassutto").first
  	
  	username = "edoardo"
  	password = "password"
  	
  	assert_equal edoardo, Credential.check(username, password)
  	
  end
  
  test "bad login as elia" do
  	elia = User.where(name: "Elia", surname: "Morassutto").first
  	
  	username = "elia"
  	password = "Password"
  	
  	assert_not_equal elia, Credential.check(username, password)

  end
  
  test "bad username" do
  	username = "dskjbvdskvjbdksbvdsbvdsbvvbdsb"
  	password = "password"
  	
  	assert_nil Credential.check(username, password)
  end
  
end
