require 'test_helper'

class ClassInfoTest < ActiveSupport::TestCase
  test "All information correct for 3C" do
    c = class_infos(:class_1)
    
    admin = users(:user_prof)
    
    assert_not_nil c
    
    assert_equal "3C", c.name
    assert_equal "informatica", c.specialization
    assert_equal 3, c.year
    assert_equal admin, c.admin
  end
end
