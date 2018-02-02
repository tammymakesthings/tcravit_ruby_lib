############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : tcravit_ruby_lib.rb
# Description : Main include file for the library; autoloads all its parts
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

$:.unshift File.dirname(__FILE__)

# Make sure we load the version definitions first
require "tcravit_ruby_lib/version"

Dir[File.join(File.dirname(__FILE__), "tcravit_ruby_lib", "*.rb")].each do |f|
  require File.join("tcravit_ruby_lib", File.basename(f)) unless File.basename(f) == "version.rb"
end

module TcravitRubyLib # :nodoc:
end

