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

# Load our custom test matchers. require_custom_matcher_named is a bit of
# syntactic sugar defined in spec_helper.rb
require_custom_matcher_named("be_a_rake_task_named")
require_custom_matcher_named("be_a_valid_gem_version_file_for")
require_custom_matcher_named("declare_the_gem_version_to_be")

RSpec.describe "bump_ver.rake" do 

  describe "version:bump:major", type: :rake do
    before(:all) do
      @test_version_file = "/tmp/bump_ver_major.out"
    end

    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:major")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(@test_version_file) if File.exist?(@test_version_file)
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment the major version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to declare_the_gem_version_to_be((initial_version[0] + 1), 0, 0)
      end
    end
  end

  describe "version:bump:minor", type: :rake do
    before(:all) do
      @test_version_file = "/tmp/bump_ver_minor.out"
    end

    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:minor")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(@test_version_file) if File.exist?(@test_version_file)
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment the minor version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to declare_the_gem_version_to_be(initial_version[0], (initial_version[1] + 1), 0) 
      end
    end
  end

  describe "version:bump:build", type: :rake do
    before(:all) do
      @test_version_file = "/tmp/bump_ver_build.out"
    end

    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:build")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(@test_version_file) if File.exist?(@test_version_file)
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should increment build version number" do
        initial_version = TcravitRubyLib::VERSION_DATA.clone
        args = to_task_arguments(1)
        task.execute(args)
        expect(@test_version_file).to declare_the_gem_version_to_be(initial_version[0], initial_version[1], (initial_version[2] + 1))
      end
    end
  end

  describe "version:bump:set", type: :rake do
    before(:all) do
      @test_version_file = "/tmp/bump_ver_set.out"
    end

    context "the basics" do 
      it "should be a rake task" do
        expect(subject).to be_a_rake_task_named("version:bump:set")
      end
    end

    context "file generation" do
      before(:each) do
        File.delete(@test_version_file) if File.exist?(@test_version_file)
      end

      it "should generate a file with the right format and module name" do
        args = to_task_arguments(3,4,5,11)
        task.execute(args)
        expect(@test_version_file).to be_a_valid_gem_version_file_for("TcravitRubyLib")
      end

      it "should generate a file with the right version number" do
        args = to_task_arguments(3,4,5,1)
        task.execute(args)
        expect(@test_version_file).to declare_the_gem_version_to_be(3, 4, 5)
      end
    end
  end
end
