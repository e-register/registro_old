require 'test_helper'

class ClassInfoTest < ActiveSupport::TestCase
  test "All information correct for 3C" do
    c = ClassInfo.where(name: "3C", specialization: "informatica").first
    
    admin = Credential.check(username: "prof", password: "password")
    
    assert_not_nil c
    
    assert_equal "3C", c.name
    assert_equal "informatica", c.specialization
    assert_equal 3, c.year
    assert_equal admin, c.admin
  end
end
