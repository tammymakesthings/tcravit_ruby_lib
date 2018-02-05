############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : utility.rb
# Description : Random small utility functions
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

require 'simple-password-gen'

module TcravitRubyLib
  ##
  # Contains random Ruby utility functions that don't fit anywhere else.
  module Utility
    extend self
    
    ##
    # Generate random alphanumeric passwords.
    #
    # Previously this method generated passwords by shuffling characters
    # in an array. It's now  just a wrapper for the +simple-password-gen+
    # gem.
    #
    # @param size [Integer] The length of the password to generate. Defaults
    # to 16 characters if not specified.
    # @param pronounceable [Boolean] True to generate pronounceable passwords.
    # Defaults to false.
    # @return [String] The generated password.
    def random_alphanumeric(size=16, pronounceable=false)
      if pronounceable then
        return Password.pronounceable(size*2)[0..(size-1)]
      else
        return Password.random(size*2)[0..(size-1)]
      end
    end
    
  end
end
