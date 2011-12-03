###########################################################################
# A bit of ruby hackery to enable the script to be run directly 
# from the command line, as well as included into other code.
# (Courtesy of elliottcable).
#
# Not autoloaded by the Gem; require 'tcravit_ruby_lib/on_execute' to pull
# it in.
###########################################################################

module Kernel
  def on_execute
    calling_file = caller.first.split(':').first
    if File.expand_path(calling_file) == File.expand_path($0)
      yield
    end
  end
end