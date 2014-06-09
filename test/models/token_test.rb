require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test "All token informations correct" do
    edoardo = Credential.check username: "edoardo", password: "password"
    token = Token.where(token: "a").first

    assert_not_nil token
    
    assert_equal edoardo, token.user    
  end
end
