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
  
  test "Get students" do
  	c = class_infos(:class_1)
  	edoardo = students(:stud_1)
  	elia = students(:stud_2)
  	
  	aspected = [ edoardo, elia ]
  	
  	assert_equal aspected, c.get_students(true)
  end
  
  test "Get teachers" do
  	c = class_infos(:class_1)
  	teacher = teachers(:teach_1)
  	
  	aspected = [ teacher ]
  	
  	assert_equal aspected, c.get_teachers(true)
  end
end
