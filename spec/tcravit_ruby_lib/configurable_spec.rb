require 'spec_helper'

class ConfigurableTest
	include TcravitRubyLib::Configurable.with(:attr_a, :attr_b, :attr_c)
end

describe "TCravitRubyLib::Configurable" do
	it "should respond to the config method and provide its configuration" do
		ConfigurableTest.should respond_to(:config)
	end

	it "should respond to the Configure method and provide a space for configuration" do
		ConfigurableTest.should respond_to(:configure)
	end

	it "should respond to attributes for the configuration accessors" do
		["attr_a", "attr_b", "attr_c"].each do |a|
			ConfigurableTest.config.should respond_to(a.to_sym)
			ConfigurableTest.config.should respond_to("#{a}=".to_sym)
		end
		["nonexistent_attr"].each do |a|
			ConfigurableTest.config.should_not respond_to(a.to_sym)
			ConfigurableTest.config.should_not respond_to("#{a}=".to_sym)
		end
	end

	it "should allow configuration" do
		ConfigurableTest.configure do
			attr_a 42
			attr_b "Squid"
			attr_c :FishPaste
		end
		ConfigurableTest.config.attr_a.should == 42
		ConfigurableTest.config.attr_b.should == "Squid"
		ConfigurableTest.config.attr_c.should == :FishPaste
	end
end
