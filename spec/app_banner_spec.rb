describe "TcravitRubyLib::AppBanner" do

	context "the basics" do
		it "should format the app banner correctly" do
			ab = TcravitRubyLib::Banner(name: "MyApp")
			lines = ab.split("\n")
			lines[0].should == ("*" * 76)
			lines[2].should == ("*" * 76)
		end
	end 

	context "app banner components" do
		it "should allow you to make a banner with just a name" do
			ab = TcravitRubyLib::Banner(name: "MyApp")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
		end

		it "should allow you to make a banner with a name and description" do
			ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp: Do some super cool stuff/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
		end

		it "should allow you to make a banner with a name and date" do
			ab = TcravitRubyLib::Banner(name: "MyApp", date: "2018-01-01")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
			lines[2].should match(/^\*\s+2018-01-01\s+\*$/)
			lines[2].length.should == 76
		end

		it "should allow you to make a banner with a name, date, description" do
			ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp: Do some super cool stuff/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
			lines[2].should match(/^\*\s+2018-01-01\s+\*$/)
			lines[2].length.should == 76
		end

		it "should allow you to make a banner with a name, date, description, version" do
			ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01", version: "1.0.1")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp: Do some super cool stuff/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
			lines[2].should match(/^\*\s+Version 1.0.1, 2018-01-01\s+\*$/)
			lines[2].length.should == 76
		end

		it "should allow you to make a banner with a name, date, description, version, author" do
			ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01", version: "1.0.1", author: "John Doe")
			lines = ab.split("\n")
			lines[1].should match(/^\*\s+MyApp: Do some super cool stuff/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 76
			lines[2].should match(/^\*\s+Version 1.0.1, 2018-01-01, John Doe\s+\*$/)
			lines[2].length.should == 76
		end
	end

	context "error handling" do
		it "should raise an error if the name is not provided" do
			lambda { TcravitRubyLib::Banner(description: "Foo")}.should raise_error(ArgumentError)
		end

		it "should raise an error if the description is too long" do
			lambda { TcravitRubyLib::Banner(description: ("*" * 133), line_length: 76)}.should raise_error(ArgumentError)
			lambda { TcravitRubyLib::Banner(description: ("*" * 128), line_length: 133)}.should raise_error(ArgumentError)
		end
	end

	context "formatting" do
		it "should allow you to change the output line length" do
			ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", line_length: 133)
			lines = ab.split("\n")
			lines[0].should == ("*" * 133)
			lines[1].should match(/^\*\s+MyApp: Do some super cool stuff/)
			lines[1].should match(/\s+\*$/)
			lines[1].length.should == 133
			lines[2].should == ("*" * 133)
		end
	end
end
