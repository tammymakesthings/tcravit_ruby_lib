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
  module Utility
    extend self
    
    def random_alphanumeric(size=16, pronounceable=false)
      if pronounceable then
        return Password.pronounceable(size*2)[0..(size-1)]
      else
        return Password.random(size*2)[0..(size-1)]
      end
    end
    
  end
end
