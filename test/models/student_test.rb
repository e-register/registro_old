require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "Student edoardo valid" do
    edoardo = users(:user_edoardo)
    classinfo = class_infos(:class_1)

    stud = Student.where(student: edoardo).first

    assert_not_nil stud

    assert_equal classinfo, stud.class_info
  end
end
