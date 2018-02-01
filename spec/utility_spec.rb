require 'spec_helper'
require "tcravit_ruby_lib/utility"

describe "TcravitRubyLib::Utility" do
	context "random_alphanumeric()" do
		it "should return a random string of the correct length" do
			s = TcravitRubyLib::Utility.random_alphanumeric(16)
			s.should_not be_nil
			s.length.should == 16
		end

		it "should return a relatively random string" do
			s = TcravitRubyLib::Utility.random_alphanumeric(256)
			frequencies = {}
			s.chars.each {|c| frequencies[c] ||= 0; frequencies[c] = frequencies[c] + 1}
			(frequencies.values.max_by { |x| x}).should be <= 25	# There's probably a better way to do this
		end

		it "should allow you to generate pronounceable passwords" do
			s = TcravitRubyLib::Utility.random_alphanumeric(32, true)
			s.length.should == 32
			s.should match(/^[A-Za-z]+/)
		end
  end
end
