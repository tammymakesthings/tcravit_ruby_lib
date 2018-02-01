# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tcravit_ruby_lib/version"

Gem::Specification.new do |s|
  s.name        = "tcravit_ruby_lib"
  s.version     = TcravitRubyLib::VERSION
  s.authors     = ["Tammy Cravit"]
  s.email       = ["tcravit@taylored-software.com"]
  s.homepage    = ""
  s.summary     = %q{Random reusable ruby stuff}

  s.rubyforge_project = "tcravit_ruby_lib"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

	s.add_dependency "simple-password-gen"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "fantaskspec"
end
