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

module TcravitRubyLib  #-nodoc-#
  def self.Banner(opts={})
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

  def self.asterisk_pad(data, length=76)
    buf = "* " + (" " * (((length-4) - data.length) / 2)) + data
    buf = buf + (" " * ((length-2) - buf.length)) + " *"
    return buf
  end

end
