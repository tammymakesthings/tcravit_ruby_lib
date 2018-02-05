############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : be_a_valid_gem_version_file_for_matcher.rb
# Description : RSpec custom matcher for Gem version files.
#
# This matcher validates the format of a Gem version.rb file. It checks the
# following:
#
# - The specified file exists
# - The specified file matches the format:
#
#     module GemName
#       VERSION_DATA = [x, y, z]
#       VERSION = VERSION_DATA.join(".")
#     end
#
# If the matcher fails, a list of the failing conditions is returned.
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

RSpec::Matchers.define :be_a_valid_gem_version_file_for do |module_name|
  match do |actual|
    @errors  = []
    if File.exist?(actual) then
      contents = TcravitRubyLib::MatchHelpers.read_output_file(actual) 
      @errors.push("expected the file to start with a module declaration") unless contents[0].match(/^\s*module/)
      @errors.push("expected the file to declare a module named \"#{module_name}\"") unless contents[0].match(/^\s*module #{module_name}/)
      @errors.push("expected the file to declare VERSION_DATA") unless contents[1].match(/^\s*VERSION_DATA =/)
      @errors.push("expected VERSION_DATA to be a [major,minor,build] array") unless contents[1].match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
      @errors.push("expected the file to end with an \"end\" line") unless contents[3]  == "end"
    else
      @errors.push("expected the file #{actual} to exist")
    end
    @errors.empty?
  end

  failure_message do |actual|
    @errors.join("\n")
  end
end
