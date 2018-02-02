require 'spec_helper'

RSpec.describe "TcravitRubyLib" do
	it "should define a VERSION constant" do
		expect(TcravitRubyLib::VERSION).to_not be_nil
		expect(TcravitRubyLib::VERSION).to match(/\d+\.\d+\.\d+/)
	end

	it "should define a VERSION_DATA array" do
		expect(TcravitRubyLib::VERSION_DATA).not_to be_nil
		expect(TcravitRubyLib::VERSION_DATA.length).to be == 3
		TcravitRubyLib::VERSION_DATA.each do |i|
			expect(i).to be_a_kind_of(Numeric)
		end
	end
end
