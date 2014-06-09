require 'test_helper'

class CredentialTest < ActiveSupport::TestCase

  test "login as edoardo" do
  	edoardo = User.where(name: "Edoardo", surname: "Morassutto").first
  	
  	username = "edoardo"
  	password = "password"
  	
  	assert_equal edoardo, Credential.check(username: username, password: password)
  	
  end
  
  test "bad login as elia" do
  	elia = User.where(name: "Elia", surname: "Morassutto").first
  	
  	username = "elia"
  	password = "Password"
  	
  	assert_not_equal elia, Credential.check(username: username, password: password)

  end
  
  test "bad username" do
  	username = rand(36**15).to_s(36)
  	password = "password"
  	
  	assert_nil Credential.check(username: username, password: password)
  end
  
  test "bad password" do

  	username = "edoardo"
  	password = "Password"
  	
  	assert_nil Credential.check(username: username, password: password)
  	
  end
  
  test "PasswordHash test" do
  	correctPassword = rand(36**15).to_s(36)
  	wrongPassword = rand(36**15).to_s(36)
  	hash = PasswordHash.createHash correctPassword
  	
  	assert PasswordHash.validatePassword(correctPassword, hash)
  	assert_not PasswordHash.validatePassword(wrongPassword, hash)
  	
  	h1 = hash.split PasswordHash::SECTION_DELIMITER
    h2 = PasswordHash.createHash(correctPassword).split(PasswordHash::SECTION_DELIMITER)
    
    assert_not_equal h1[PasswordHash::HASH_INDEX], h2[PasswordHash::HASH_INDEX]
    assert_not_equal h1[PasswordHash::SALT_INDEX], h2[PasswordHash::SALT_INDEX]
  	
  end
  
end
