############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : version_bump_rake_tasks_spec.rb
# Specs for   : version:bump rake tasks in tcravit_ruby_lib/rake_tasks
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
require "tcravit_ruby_lib/rake_tasks"
require "fantaskspec"
require 'fileutils'

require_helper_named "release_tasks_helper"

# Load our custom test matchers. require_custom_matcher_named is a bit of
# syntactic sugar defined in spec_helper.rb
require_custom_matcher_named "be_a_rake_task_named"
require_custom_matcher_named "be_a_valid_gem_version_file_for"
require_custom_matcher_named "declare_the_gem_version_to_be"

RSpec.describe "bump_ver.rake" do

  describe "version:bump:major", type: :rake do
    before(:all) do
      @mock_gem_dir = File.join("/tmp", "mock_gem")
      @test_version_file = File.join(@mock_gem_dir, "lib", "mock_gem", "version.rb")
      ENV["mock_gem_dir"] = @mock_gem_dir
    end

    before(:each) do
      FileUtils.remove_dir @mock_gem_dir if Dir.exist?(@mock_gem_dir)
      create_mock_gem_in @mock_gem_dir
    end

    after(:each) do
      FileUtils.remove_dir @mock_gem_dir
    end

    context "the basics" do
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:major")
      end
    end

    context "file generation" do
      it "should generate a file with the right format and module name" do
        task.execute
        expect(@test_version_file).to be_a_valid_gem_version_file_for("MockGem")
      end

      it "should increment the major version number" do
        task.execute
        expect(@test_version_file).to declare_the_gem_version_to_be(2, 0, 0)
      end
    end
  end

  describe "version:bump:minor", type: :rake do
    before(:all) do
      @mock_gem_dir = File.join("/tmp", "mock_gem")
      @test_version_file = File.join(@mock_gem_dir, "lib", "mock_gem", "version.rb")
      ENV["mock_gem_dir"] = @mock_gem_dir
    end

    before(:each) do
      create_mock_gem_in @mock_gem_dir
    end

    after(:each) do
      FileUtils.remove_dir @mock_gem_dir
    end

    context "the basics" do
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:minor")
      end
    end

    context "file generation" do
      it "should generate a file with the right format and module name" do
        task.execute
        expect(@test_version_file).to be_a_valid_gem_version_file_for("MockGem")
      end

      it "should increment the minor version number" do
        task.execute
        expect(@test_version_file).to declare_the_gem_version_to_be(1, 1, 0)
      end
    end
  end

  describe "version:bump:build", type: :rake do
    before(:all) do
      @mock_gem_dir = File.join("/tmp", "mock_gem")
      @test_version_file = File.join(@mock_gem_dir, "lib", "mock_gem", "version.rb")
      ENV["mock_gem_dir"] = @mock_gem_dir
    end

    before(:each) do
      create_mock_gem_in @mock_gem_dir
    end

    after(:each) do
      FileUtils.remove_dir @mock_gem_dir
    end

    context "the basics" do
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:build")
      end
    end

    context "file generation" do
      it "should generate a file with the right format and module name" do
        task.execute
        expect(@test_version_file).to be_a_valid_gem_version_file_for("MockGem")
      end

      it "should increment build version number" do
        task.execute
        expect(@test_version_file).to declare_the_gem_version_to_be(1, 0, 6)
      end
    end
  end

  describe "version:bump:set", type: :rake do
    before(:all) do
      @mock_gem_dir = File.join("/tmp", "mock_gem")
      @test_version_file = File.join(@mock_gem_dir, "lib", "mock_gem", "version.rb")
      ENV["mock_gem_dir"] = @mock_gem_dir
    end

    before(:each) do
      create_mock_gem_in @mock_gem_dir
    end

    after(:each) do
      FileUtils.remove_dir @mock_gem_dir
    end

    context "the basics" do
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:set")
      end
    end

    context "file generation" do
      it "should generate a file with the right format and module name" do
        args = to_task_arguments(3,4,5)
        task.execute(args)
        expect(@test_version_file).to be_a_valid_gem_version_file_for("MockGem")
      end

      it "should generate a file with the right version number" do
        args = to_task_arguments(3,4,5)
        task.execute(args)
        expect(@test_version_file).to declare_the_gem_version_to_be(3, 4, 5)
      end
    end
  end
end
