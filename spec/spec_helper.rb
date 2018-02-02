require 'rspec'
require 'tcravit_ruby_lib'

RSpec.configure do |config|
#  config.formatter     = 'progress'
  config.formatter     = 'documentation'
  config.expect_with :rspec do |c|
    c.syntax = :expect
    c.on_potential_false_positives = :nothing
  end
end
