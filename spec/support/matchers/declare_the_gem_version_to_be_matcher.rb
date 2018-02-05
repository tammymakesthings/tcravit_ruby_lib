############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : declare_the_gem_version_to_be_matcher.rb
# Description : RSpec custom matcher to check the version declared in a
#               Rubygem version.rb file.
#
# This matcher assumes the file format conforms to the format described in
# be_a_valid_gem_version_file_for_matcher.rb and checks that it declares
# itself to be of the specified version. If you want to skip checking any
# component of the version number, pass a nil value for the expected 
# versions.
#
# If the matcher fails, a list of which components mismatched is returned.
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

require 'rspec/expectations'
require File.join(File.dirname(__FILE__), "matcher_helpers.rb")

RSpec::Matchers.define :declare_the_gem_version_to_be do |expected_major, expected_minor, expected_build|
  match do |actual|
    contents = TcravitRubyLib::MatchHelpers.read_output_file(actual)
    v = eval(contents[1].downcase)
    unless expected_major.nil?
      expect(v[0]).to be == expected_major
    end
    unless expected_minor.nil?
      expect(v[1]).to be == expected_minor
    end
    unless expected_build.nil?
      expect(v[2]).to be == expected_build
    end
  end
end
