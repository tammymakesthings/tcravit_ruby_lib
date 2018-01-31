$:.unshift File.dirname(__FILE__)

require "tcravit_ruby_lib/version"

Dir[File.join(File.dirname(__FILE__), "tcravit_ruby_lib", "*.rb")].each do |f|
	require File.join("tcravit_ruby_lib", File.basename(f)) unless File.basename(f) == "version.rb"
end

module TcravitRubyLib # :nodoc:
end

