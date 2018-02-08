############################################################################
# Rake tasks for versioning a Gem
#
# Version 1.0, 2018-02-01, tammycravit@me.com
############################################################################
#  Copyright 2018, Tammy Cravit.
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
require 'git'

namespace :release do
  desc "Prepare for release by incrementing the build number and checking in version.rb"
  task :prepare do
    begin
      Rake::Task["version:bump:build"].invoke
      g = Git.open(Rake.original_dir)
      g.add(File.join(Rake.original_dir, "lib", File.basename(Rake.original_dir), "version.rb"))
      g.commit("Bump version (via release:prepare rake task)")
      puts "Committed version.rb to git"
    rescue 
      puts "Rake task release:prepare failed!"
    end
  end
end
