require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
    test "All subject infos correct" do
        s = Subject.where(name: "Matematica").first
        
        assert_not_nil s
        
        assert_equal "Matematica", s.name
        assert_equal "Matematica", s.description
    end
end
