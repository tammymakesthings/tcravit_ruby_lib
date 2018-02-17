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

# A helper to run a Rake task in a specific directory
def run_rake_task_in_dir(dir_name, task_name)
  system("cd #{dir_name}; rake -f #{dir_name}/Rakefile #{task_name}")
end

RSpec.describe "release_tasks.rake", type: :rake do
  describe "release:prepare" do
    before(:all) do
      @base_dir = File.join("/tmp", "release_prepare_test")
      FileUtils.remove_dir(@base_dir) if Dir.exist?(@base_dir)
    end

    after(:each) do
       FileUtils.remove_dir(@base_dir) if Dir.exist?(@base_dir)
    end

    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("release:prepare")
    end

    it "should bump the gem version" do
      create_mock_gem_in(@base_dir)
      run_rake_task_in_dir(@base_dir, "release:prepare")

      ver_file = File.join(@base_dir, "lib", "mock_gem", "version.rb")
      expect(ver_file).to be_a_valid_gem_version_file_for("MockGem")
      expect(ver_file).to declare_the_gem_version_to_be(1,0,6)
    end

    it "should check in the version file to git" do
      create_mock_gem_in(@base_dir)
      run_rake_task_in_dir(@base_dir, "release:prepare")

      g = Git.open(@base_dir)
      expect(g.log.first.message).to be == "Bump version (via release:prepare rake task)"
      expect(g.status['lib/mock_gem/version.rb'].type).to be_nil
    end
  end
end
