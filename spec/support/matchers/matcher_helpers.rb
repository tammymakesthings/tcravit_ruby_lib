############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : matcher_helpers.rb
# Description : Helper functions for the RSpec custom matchers in this
#               directory.
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

module TcravitRubyLib
  module MatchHelpers
    
    ##
    # Read a text file and return its contents as an array of strings. If
    # the file is not found or an error occurs, returns an empty array.

    def self.read_output_file(f)
      lines = []

      if File.exist?(f)
        begin
          fh = open(f)
          fh.each { |l| lines.push(l.chomp) }
          fh.close
        rescue
          return []
        end
      end
      return lines
    end

  end
end
