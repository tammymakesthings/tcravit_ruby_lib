require 'spec_helper'
require 'fileutils'

describe "TcravitRubyLib::AppConfig" do
    
  STRING_VAL = "string"
  NUMERIC_VAL = 18293
  SYMBOLIC_VAL = :squid
  
  before(:all) do
    TcravitRubyLib::AppConfig.configure do
      string_value STRING_VAL
      numeric_value NUMERIC_VAL
      symbol_value SYMBOLIC_VAL
    end
  end
  
  it "should return the values for defined properties" do
    TcravitRubyLib::AppConfig.string_value.should == STRING_VAL
    TcravitRubyLib::AppConfig.numeric_value.should == NUMERIC_VAL
    TcravitRubyLib::AppConfig.symbol_value.should == SYMBOLIC_VAL      
  end
  
  it "should raise an error for undefined properties" do
    lambda { TcravitRubyLib::AppConfig.fishpaste_value }.should raise_error
  end
  
  it "should allow me to change a configuration property" do
    TcravitRubyLib::AppConfig.string_value = "new value"
    TcravitRubyLib::AppConfig.string_value.should == "new value"
  end
  
  it "should allow me to remove a configuration property" do
    TcravitRubyLib::AppConfig.remove!(:string_value)
    lambda { TcravitRubyLib::AppConfig.string_value }.should raise_error
  end
  
  it "should allow additional properties to be added" do
    TcravitRubyLib::AppConfig.configure do
      another_value 192
    end
    TcravitRubyLib::AppConfig.configure do
      and_another_value 384
    end
    TcravitRubyLib::AppConfig.another_value.should == 192
    TcravitRubyLib::AppConfig.and_another_value.should == 384
  end
  
end
