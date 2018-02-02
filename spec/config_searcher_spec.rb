require 'spec_helper'
require 'fileutils'

RSpec.describe "TcravitRubyLib::ConfigSearcher" do

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

	context "the basics" do
		it "should successfully find a directory which exists" do
			dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".config")
			expect(dir_path.to_s).to_not be_nil
			expect(dir_path.to_s).to be == CONFIG_DIR
		end

		it "should not find a directory when one doesn't exist" do
			dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".snausages")
			expect(dir_path.to_s).to be == ""    
		end

		it "should return the container dir when the only_container_dir option is provided" do
			dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: DEEP_DIR, look_for: ".config", only_container_dir: true)
			expect(dir_path.to_s).to be == BASE_DIR
		end
	end

	context "error handling" do
		it "should raise an exception when the start_in directory doesn't exist" do
			expect { TcravitRubyLib::ConfigSearcher.locate_config_dir(start_in: "#{DEEP_DIR}xxxxxxx", look_for: ".snausages") }.to raise_error
		end
	end

	context "alternative option names" do
		it "should behave the same for the alternative option names" do
			dir_path = TcravitRubyLib::ConfigSearcher.locate_config_dir(start_dir: DEEP_DIR, config_dir: ".config")
			expect(dir_path.to_s).to_not be_nil
			expect(dir_path.to_s).to be == CONFIG_DIR
		end
	end	
end
