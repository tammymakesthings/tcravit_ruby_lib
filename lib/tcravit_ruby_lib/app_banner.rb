############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : app_banner.rb
# Description : Helper function for generating app startup banners for
#               command line applications/scripts.
############################################################################
#  Copyright 2011-2018, Tammy Cravit.
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

module TcravitRubyLib #-nodoc-#  

  extend self

  ##
  # Generate an app startup banner for a command-line application.
  #
  # == Banner Formatting
  #
  # The app banner will be framed with asterisks. By default, it will be 76
  # characters long, though this can be overridden by passing in a value for
  # +line_length+.
  #
  # If a +description+ is included, the first text line of the banner will
  # take the form "name: description"; otherwise, just the name will be
  # output. This line will be centered, with whitespace added to the ends to
  # make the asterisks line up. Otherwise, just the app name will be output.
  #
  # If any of +version+, +date+, and/or +author+ are supplied, these will be
  # joined (in that order) by commas, and a second centered line of text
  # containing those components will be output. If none are supplied, no
  # second line will be output.
  #
  # == Arguments
  #
  # For flexibility, parameters are all passed in a hash. The method accepts
  # the following options:
  #
  # * `:name` - The name of the application. Required.
  # * `:description` - A brief description of the application. Optional.
  # * `:version`
  # * `:date`
  # * `:author`
  # * `:line_length`
  #
  # The only required option is +name+, and an ArgumentError will be raised
  # if it is not supplied. All other options are optional, and the method
  # will simply use whichever ones are supplied to generate the banner.
  #
  # For examples, see the RSpec tests for this method.
  #
  # @param opts [Hash] A hash of options.
  # @return [String] The app banner, ready to print out
  def Banner(opts={})
    raise ArgumentError, "Name not provided" unless opts.keys.include?("name".to_sym)
  
    line_length = 76
    line_length = opts[:line_length] if opts.keys.include?(:line_length)

    lines = []
    lines.push("*" * line_length)

    name_line = "#{opts[:name]}"
    if (opts.keys.include?(:description)) then
      name_line = name_line + ": " + opts[:description]
    end
    lines.push(asterisk_pad(name_line, line_length))

    date_line_parts = []
    if (opts.keys.include?(:version)) then
      date_line_parts.push("Version #{opts[:version]}")
    end
    if (opts.keys.include?(:date)) then
      date_line_parts.push(opts[:date])
    end
    if (opts.keys.include?(:author)) then
      date_line_parts.push(opts[:author])
    end
    unless date_line_parts.empty?
      lines.push(asterisk_pad(date_line_parts.join(", ")))
    end

    lines.push("*" * line_length)
    
    return lines.join("\n")
  end

  private 
  def asterisk_pad(data, length=76)
    buf = "* " + (" " * (((length-4) - data.length) / 2)) + data
    buf = buf + (" " * ((length-2) - buf.length)) + " *"
    return buf
  end

end
