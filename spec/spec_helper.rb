require 'rspec'
require 'tcravit_ruby_lib'

RSpec.configure do |config|
#  config.color_enabled = true
  config.formatter     = 'documentation'
#	config.expect_with(:rspec) { |c| c.syntax = :should }
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
