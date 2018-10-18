############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : spec_helper.rb
# Decription  : RSpec configuration and global helper functions for testing
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

require 'simplecov'
SimpleCov.start do
  add_group "Library", "lib"
  add_group "Tests",   "spec"
end

ENV['RSPEC_RUNNING'] = "true"

require 'rspec'
require 'tcravit_ruby_lib'

# A quick-and-dirty method to load RSpec helper files in spec/support
def require_helper_named(helper_name)
  require "#{File.join(
    File.dirname(__FILE__),
    "support",
    "#{helper_name}.rb")}"
end

# A quick-and-dirty method to load RSpec matchers in spec/support/matchers
def require_custom_matcher_named(matcher_name)
  require "#{File.join(
    File.dirname(__FILE__),
    "support", "matchers",
    "#{matcher_name}_matcher.rb")}"
end

RSpec.configure do |config|
  config.formatter     = 'progress'
#  config.formatter     = 'documentation'
  config.expect_with :rspec do |c|
    c.syntax = :expect
    c.on_potential_false_positives = :nothing
  end
end
