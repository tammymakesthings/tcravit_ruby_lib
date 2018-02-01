############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : rake_tasks.rb
# Description : Helper for loading shared Rake tasks
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

require 'rake'

module TcravitRubyLib
	class RakeTasks
		include Rake::DSL if defined?(Rake::DSL)

		def install_tasks
			Dir["#{File.join(File.dirname(__FILE__), 'tasks')}/**/*.rake"].each do |f|
				load f
			end
		end
	end
end

TcravitRubyLib::RakeTasks.new.install_tasks
