require 'rspec/core/rake_task'
require "bundler/gem_tasks"
Dir.glob("#{File.join(File.dirname(__FILE__), 'tasks')}/**/*.rake").each { |r| load r }

RSpec::Core::RakeTask.new('spec')

task :default => [:spec]
