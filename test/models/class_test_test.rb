require 'test_helper'

class ClassTestTest < ActiveSupport::TestCase
  test "All information correct for ClassTest" do
    c = class_tests(:class_test_1)
    
    assert_not_nil c
    
    assert_equal "Compito sugli integrali", c.description
  end
end
