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

require_custom_matcher_named("be_a_rake_task_named")
require_custom_matcher_named("be_a_valid_gem_version_file_for")
require_custom_matcher_named("declare_the_gem_version_to_be")

TEST_VERSION_FILE = "/tmp/bump_ver.out"

describe "bump_ver.rake" do 
  describe "version:bump:major", type: :rake do
    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:major")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment the major version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be((initial_version[0] + 1), initial_version[1], initial_version[2])
      end
    end
  end

  describe "version:bump:minor", type: :rake do
    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:minor")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment the minor version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(initial_version[0], (initial_version[1] + 1), initial_version[2])
      end
    end
  end

  describe "version:bump:build", type: :rake do
    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:build")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment build version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(initial_version[0], initial_version[1], (initial_version[2] + 1))
      end
    end
  end

  describe "version:bump:set", type: :rake do
    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:set")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(3,4,5,11)
        task.execute(args)
        expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should generate a file with the right version number" do
        args = to_task_arguments(3,4,5,1)
        task.execute(args)
        expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(3, 4, 5)
      end
    end
  end
end
