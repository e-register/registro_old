require 'test_helper'

class ClassTestTest < ActiveSupport::TestCase
  test "All information correct for ClassTest" do
    c = ClassTest.where(description: "Compito sugli integrali").first
    
    assert_not_nil c
    
    assert_equal "Compito sugli integrali", c.description
  end
end
