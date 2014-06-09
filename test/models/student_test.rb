require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "Student edoardo valid" do
    user = Credential.check username: "edoardo", password: "password"
    classinfo = ClassInfo.where(name: "3C", specialization: "informatica").first
    stud = Student.where(student: user).first
    
    assert_not_nil stud
    
    assert_equal classinfo, stud.class_info
  end
end
