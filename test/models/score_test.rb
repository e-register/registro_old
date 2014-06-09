require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  test "Test all scores" do
    10.times do |i|
      s = Score.where(value: i+1).first
      assert_not_nil s
      
      assert_equal i+1, s.value
      assert_equal "#{i+1}", s.text
    end
  end
end
