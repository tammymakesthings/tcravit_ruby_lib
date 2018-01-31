require 'spec_helper'
require 'fileutils'

describe "TcravitRubyLib::ConfigSearcher" do

  BASE_DIR   = '/tmp/config_searcher_test'
  DEEP_DIR   = "#{BASE_DIR}/foo/bar/baz"
  CONFIG_DIR = "#{BASE_DIR}/.config"

  before(:all) do
    FileUtils.mkdir_p DEEP_DIR
    FileUtils.mkdir_p CONFIG_DIR
  end

  after(:all) do
    FileUtils.remove_dir BASE_DIR, true
  end

  it "should successfully find a directory which exists" do
    dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".config")
    dir_path.to_s.should_not be_nil
    dir_path.to_s.should == CONFIG_DIR
  end

  it "should not find a directory when one doesn't exist" do
    dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".snausages")
    dir_path.to_s.should == ""    
  end

  it "should return the container dir when the only_container_dir option is provided" do
    dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".config", only_container_dir: true)
    dir_path.to_s.should == BASE_DIR
  end
  
  it "should raise an exception when the start_in directory doesn't exist" do
		caught_ex = false
		begin
			TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: "#{DEEP_DIR}xxxxxxx", look_for: ".snausages")
		rescue ArgumentError
			caught_ex = true
		end
		caught_ex.should == true
  end

  it "should behave the same for the alternative option names" do
    dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_dir: DEEP_DIR, config_dir: ".config")
    dir_path.to_s.should_not be_nil
    dir_path.to_s.should == CONFIG_DIR
  end
  
end
