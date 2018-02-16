############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : release_helper_spec.rb
# Specs for   : spec/support/release_tasks_helper
############################################################################
#  Copyright 2011-2018, Tammy Cravit.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
############################################################################

require 'spec_helper'
require "rake"
require "git"
require "fileutils"

# Load our helpers
require_helper_named("release_tasks_helper")

# Load our custom test matchers. require_custom_matcher_named is a bit of
# syntactic sugar defined in spec_helper.rb
require_custom_matcher_named("be_a_valid_gem_version_file_for")

RSpec.describe "release_tasks_helper" do
  before(:all) do
    @basedir = File.join("/tmp", "mock_gem_test")
    create_mock_gem_in(@basedir)
  end

  after(:all) do
    FileUtils.remove_dir(@basedir)
  end

  context "preliminaries" do
    it "should create a mock gem in the expected directory" do
      expect(File).to exist(@basedir)
    end
  end

  context "generated files/directories" do
    it "should generate a .git subdirectory in the test directory" do
      expect(File).to exist(File.join(@basedir, ".git"))
    end

    it "should generate a Gemfile in the test directory" do
      expect(File).to exist(File.join(@basedir, "Gemfile"))
    end

    it "should generate a Rakefile in the test directory" do
      expect(File).to exist(File.join(@basedir, "Rakefile"))
    end

    it "should create a gemspec in the test directory" do
      expect(File).to exist(File.join(@basedir, "mock_gem.gemspec"))
    end

    it "should create the lib directory tree in the test directory" do
      expect(File).to exist(File.join(@basedir, "lib"))
    end

    it "should create a mock_gem.rb file in the lib directory" do
      expect(File).to exist(File.join(@basedir, "lib", "mock_gem.rb"))
    end
  end

  context "version file validity" do
    it "should create a valid version.rb file in the lib directory" do
      filename = File.join(@basedir, "lib", "mock_gem", "version.rb")
      expect(File).to exist(filename)
      expect(filename).to be_a_valid_gem_version_file_for("MockGem")
    end
  end

  context "Git integration" do
    before(:all) do
      @git = Git.open(@basedir)
    end

    it "should be a git repository" do
      expect(@git).not_to be_nil
      expect(@git).to be_a(Git::Base)
    end

    it "should check all the files into the git repo" do
      [
        "Gemfile",
        "Rakefile",
        "mock_gem.gemspec",
        File.join("lib", "mock_gem.rb"),
        File.join("lib", "mock_gem", "version.rb"),
      ].each do |file|
        expect(@git.status[file]).not_to be_nil
      end
    end

    it "should have the right commit message" do
      expect(@git.log.first.message).to be == "Initial revision"
    end
  end
end
