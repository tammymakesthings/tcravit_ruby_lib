describe "TcravitRubyLib" do
	it "should define a VERSION constant" do
		TcravitRubyLib::VERSION.should_not be_nil
		TcravitRubyLib::VERSION.should match(/\d+\.\d+\.\d+/)
	end

	it "should define a VERSION_DATA array" do
		TcravitRubyLib::VERSION_DATA.should_not be_nil
		TcravitRubyLib::VERSION_DATA.length.should == 3
		TcravitRubyLib::VERSION_DATA.each do |i|
			i.should be_a_kind_of(Numeric)
		end
	end
end
