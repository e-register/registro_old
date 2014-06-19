require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  # TODO modificare la JoinTable!
  test "All information correct for Teacher" do
    user = Credential.check username: "prof", password: "password"
    classinfo = ClassInfo.where(name: "3C", specialization: "informatica").first
    subject = Subject.where(name: "Matematica").first

    teacher = Teacher.where(teacher: user).first

    assert_not_nil teacher

    assert_equal user, teacher.teacher
    assert_equal classinfo, teacher.class_info
    assert_equal subject, teacher.subject
  end
end
