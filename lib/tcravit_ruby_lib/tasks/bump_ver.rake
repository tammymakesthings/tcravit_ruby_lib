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
  # mock_gem_dir is set by the RSpec specs to override the search directory
  if ENV.include?("mock_gem_dir") and Dir.exist?(ENV['mock_gem_dir'])
    rake_dir = ENV["mock_gem_dir"]
  else
    rake_dir = Rake.original_dir
  end

  if File.directory?(rake_dir) then
    ver_file = Dir["#{rake_dir}/**/version.rb"]
    if ver_file.nil?
      return nil
    else
      return ver_file[0]
    end
  end
end

def write_output_to(file, output)
  open(file, "w") do |f|
    f.puts(output)
  end
end

def create_file_contents(module_name, version_data)
  buf = "module #{module_name}\n"
  buf = buf + "\tVERSION_DATA = [" + version_data.join(", ") + "]\n"
  buf = buf + "\tVERSION = VERSION_DATA.join(\".\")\n"
  buf = buf + "end\n"
end

def load_gem_version_file
  version_file = find_version_file
  if version_file.nil?
    raise ArgumentError, "Could not find version file"
    exit
  end
  require version_file
  return version_file
end

def find_module_name_from(version_file)
  module_name = ""
  File.foreach(version_file) do |l|
    next if l.match(/^\s*$/)
    next if l.match(/^\s*\#/)
    m = l.match(/^\s*module (\S+)\s*$/)
    unless  m.nil?
      module_name = m[1]
      break
    end
  end
  return module_name
end

def update_gem_version_part(index=2, test_mode=false)
  positions = ['major', 'minor', 'build']

  version_file = load_gem_version_file
  module_name = find_module_name_from(version_file)

  vd = instance_eval "#{module_name}::VERSION_DATA"
  vd[index] = vd[index] + 1
  if (index < 2)
    vd[2] = 0
  end
  if (index == 0)
    vd[1] = 0
  end

  write_output_to(version_file, create_file_contents(module_name, vd))

  puts "Updated #{positions[index]} number to #{vd[index]}; version is now #{vd.join('.')}" unless test_mode
end

def set_gem_version(major, minor, build, test_mode=false)
  version_file = load_gem_version_file
  module_name = find_module_name_from(version_file)

  vd = [major, minor, build]

  write_output_to(version_file, create_file_contents(module_name, vd))

  puts "Forced Gem version to #{vd.join('.')}" unless test_mode
end

namespace :version do
  namespace :bump do
    desc 'Increment the major number of the gem'
    task :major do |t, args|
      update_gem_version_part 0, ENV.include?("RSPEC_RUNNING")
    end

    desc 'Increment the minor number of the gem'
    task :minor do |t, args|
      update_gem_version_part 1, ENV.include?("RSPEC_RUNNING")
    end

    desc 'Increment the build number of the gem'
    task :build do |t, args|
      update_gem_version_part 2, ENV.include?("RSPEC_RUNNING")
    end

    desc "Set the version number to a specific version"
    task :set, [:major, :minor, :build]  do |t, args|
      major = args[:major] || 1
      minor = args[:minor] || 0
      build = args[:build] || 0

      set_gem_version major, minor, build, ENV.include?("RSPEC_RUNNING")
    end
  end
end
