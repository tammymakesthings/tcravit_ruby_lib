############################################################################
# Rake tasks to update the version.rb file for a Gem
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

def find_version_file
	curr_dir = File.dirname(__FILE__)
	while File.exist?(File.join(curr_dir, "Rakefile")) == false
		if curr_dir == "/"
			return nil
		else
			curr_dir = File.expand_path(curr_dir + "/..")
		end
	end
	if File.directory?(File.join(curr_dir)) then
		ver_file = Dir["#{curr_dir}/**/version.rb"]
		if ver_file.nil?
			return nil
		else
			return ver_file[0]
		end
	end
end

def update_gem_version_part(index=2)
	version_file = find_version_file
	if version_file.nil?
		raise ArgumentError, "Could not find version file"
		exit
	end
	require version_file

	positions = ['major', 'minor', 'build']

	vd = TcravitRubyLib::VERSION_DATA
	vd[index] = vd[index] + 1

	buf = "module TcravitRubyLib\n"
	buf = buf + "\tVERSION_DATA = [" + vd.join(", ") + "]\n"
	buf = buf + "\tVERSION = VERSION_DATA.join(\".\")\n"
	buf = buf + "end\n"

	open(version_file, "w") do |f|
		f.puts(buf)
	end

	puts "Updated #{positions[index]} number to #{vd[index]}; version is now #{vd.join('.')}"
end

def set_gem_version(major, minor, build)
	version_file = find_version_file
	if version_file.nil?
		raise ArgumentError, "Could not find version file"
		exit
	end
	vd = [major, minor, build]

	buf = "module TcravitRubyLib\n"
	buf = buf + "\tVERSION_DATA = [" + vd.join(", ") + "]\n"
	buf = buf + "\tVERSION = VERSION_DATA.join(\".\")\n"
	buf = buf + "end\n"

	open(version_file, "w") do |f|
		f.puts(buf)
	end

	puts "Forced Gem version to #{vd.join('.')}"
end

namespace :version do
	namespace :bump do
		desc 'Increment the major number of the gem'
		task :major do
			update_gem_version_part 0
		end

		desc 'Increment the minor number of the gem'
		task :minor do
			update_gem_version_part 1
		end

		desc 'Increment the build number of the gem'
		task :build do
			update_gem_version_part 2
		end

		desc "Set the version number to a specific version"
		task :set, [:major, :minor, :build] do |t, args|
			major = args[:major] || 1
			minor = args[:minor] || 0
			build = args[:build] || 0

			set_gem_version major, minor, build
		end
	end
end
