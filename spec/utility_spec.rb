require 'spec_helper'
require "tcravit_ruby_lib/utility"

RSpec.describe "TcravitRubyLib::Utility" do
	context "random_alphanumeric()" do
		it "should return a random string of the correct length" do
			s = TcravitRubyLib::Utility.random_alphanumeric(16)
			expect(s).not_to be_nil
			expect(s.length).to be == 16
		end

		it "should return a relatively random string" do
			s = TcravitRubyLib::Utility.random_alphanumeric(256)
			frequencies = {}
			s.chars.each {|c| frequencies[c] ||= 0; frequencies[c] = frequencies[c] + 1}
			expect(frequencies.values.max_by { |x| x}).to be <= 25	# There's probably a better way to do this
		end

		it "should allow you to generate pronounceable passwords" do
			s = TcravitRubyLib::Utility.random_alphanumeric(32, true)
			expect(s.length).to be == 32
			expect(s).to match(/^[A-Za-z]+/)
		end
  end
end
