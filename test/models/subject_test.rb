require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
    test "All subject infos correct" do
        s1 = subjects(:mate)
        s2 = Subject.where(name: s1.name).first
        
        assert_not_nil s2
        
        assert_equal s1.name, s2.name
        assert_equal s1.description, s2.description
    end
end
