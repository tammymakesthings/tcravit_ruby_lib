require 'fileutils'
require 'git'

def create_mock_gem_in(mock_dir)
  Dir.mkdir(mock_dir) unless Dir.exist?(mock_dir)
  Dir.mkdir(File.join(mock_dir, "lib"))
  Dir.mkdir(File.join(mock_dir, "lib", "mock_gem"))

  File.open(File.join(mock_dir, "Rakefile"), "w") do |f|
    f.puts "require 'rspec/core/rake_task'"
    f.puts "require 'bundler/gem_tasks'"
    f.puts "require 'tcravit_ruby_lib/rake_tasks'"
    f.puts ""
    f.puts "RSpec::Core::RakeTask.new('spec')"
    f.puts ""
    f.puts "task :default => [:spec]"
  end

  File.open(File.join(mock_dir, "Gemfile"), "w") do |f|
    f.puts 'source "http://rubygems.org"'
    f.puts ''
    f.puts '# Specify your Gem\'s dependencies in mock_gem.gemspec'
    f.puts 'gemspec'
  end

  File.open(File.join(mock_dir, "mock_gem.gemspec"), "w") do |f|
    f.puts '# -*- encoding: utf-8 -*-'
    f.puts '$:.push File.expand_path("../lib", __FILE__)'
    f.puts 'require "mock_gem/version"'
    f.puts ''
    f.puts 'Gem::Specification.new do |s|'
    f.puts '  s.name        = "mock_gem"'
    f.puts '  s.version     = MockGem::VERSION'
    f.puts '  s.authors     = ["Tammy Cravit"]'
    f.puts '  s.email       = ["tammycravit@me.com"]'
    f.puts '  s.homepage    = "https://github.com/tammycravit/mock_gem"'
    f.puts '  s.summary     = %q{Mock gem for testing}'
    f.puts '  s.license     = "Apache-2.0"'
    f.puts ''
    f.puts '  s.rubyforge_project = "mock_gem"'
    f.puts ''
    f.puts '  s.files         = `git ls-files`.split("\n")'
    f.puts '  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")'
    f.puts '  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f)  }'
    f.puts '  s.require_paths = ["lib"]'
    f.puts 'end'
  end

  File.open(File.join(mock_dir, "lib", "mock_gem", "version.rb"), "w") do |f|
    f.puts 'module MockGem'
    f.puts '  VERSION_DATA = [1, 0, 5]'
    f.puts '  VERSION = VERSION_DATA.join(".")'
    f.puts 'end'
  end

  File.open(File.join(mock_dir, "lib", "mock_gem.rb"), "w") do |f|
    f.puts '$:.unshift File.dirname(__FILE__)'
    f.puts ''
    f.puts 'require mock_gem/version'
    f.puts ''
    f.puts 'module MockGem  # :nodoc:'
    f.puts 'end'
  end

  g = Git.init(mock_dir)
  g.add(all: true)
  g.commit("Initial revision")
end
