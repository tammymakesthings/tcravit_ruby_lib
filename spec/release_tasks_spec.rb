############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : release_tasks_spec.rb
# Specs for   : release rake tasks in tcravit_ruby_lib/rake_tasks
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
require "git"
require "fileutils"

# Load our helpers
require_helper_named("release_tasks_helper")

# Load our custom test matchers. require_custom_matcher_named is a bit of
# syntactic sugar defined in spec_helper.rb
require_custom_matcher_named("be_a_rake_task_named")
require_custom_matcher_named("be_a_valid_gem_version_file_for")
require_custom_matcher_named("declare_the_gem_version_to_be")

RSpec.describe "release_tasks.rake", type: :rake do
  describe "release:prepare" do
    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("release:prepare")
    end

    it "should bump the gem version" do
      pending
      # create_mock_gem_in("/tmp/release_prepare_test")
      # system("cd /tmp/release_prepare_test ; rake release:prepare")
      # Run the "release:prepare" task in /tmp/release_prepare_test
      # Check the gem version in /tmp/release_prepare_test
    end

    it "should check in the version file to git" do
      pending
      # create_mock_gem_in("/tmp/release_prepare_test")
      # Run the "release:prepare" task in /tmp/release_prepare_test
      # Check that version.rb was committed to git with the right message
    end

  end
end
