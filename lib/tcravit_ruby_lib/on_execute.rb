############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : on_execute.rb
# Description : Make a script both includable and directly runnable
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


module Kernel
  #########################################################################
  # A bit of ruby hackery to enable the script to be run directly 
  # from the command line, as well as included into other code.
  # (Courtesy of elliottcable).
  #
  # Example:
  #
  #    class MyApp
  #      # ...
  #      def start()
  #        #...
  #      end
  #    end
  #
  #    on_execute do
  #      MyApp.new().start()
  #    end 
  #########################################################################
  def on_execute
    calling_file = caller.first.split(':').first
    if File.expand_path(calling_file) == File.expand_path($0)
      yield
    end
  end
end
