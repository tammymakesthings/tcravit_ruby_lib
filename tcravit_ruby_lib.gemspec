# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tcravit_ruby_lib/version"

Gem::Specification.new do |s|
  s.name        = "tcravit_ruby_lib"
  s.version     = TcravitRubyLib::VERSION
  s.authors     = ["Tammy Cravit"]
  s.email       = ["tammycravit@me.com"]
  s.homepage    = "https://github.com/tammycravit/tcravit_ruby_lib"
  s.summary     = %q{Random reusable ruby stuff}
  s.license     = 'Apache-2.0'

  s.rubyforge_project = "tcravit_ruby_lib"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

	s.add_dependency 'simple-password-gen', '~> 0.1'
	s.add_dependency 'git'

  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'fantaskspec', '~> 1.1'
  s.add_development_dependency 'coderay', '~> 1.1'
end
