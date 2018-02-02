############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : config_searcher.rb
# Description : Locate the configuration directory for an app by traversing
#               the filesystem looking for a .git directory.
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

require 'pathname'

module TcravitRubyLib #:nodoc:

  # Utilities for locating a configuration directory within a tree.
  #
  # Unix utilities such as +git+ will look for the .git directory in a 
  # project by starting with the current directory and traversing upward
  # until a .git folder is found. This allows local configuration in a 
  # subdirectory to override a global configuration file upstream.
  #
  # This module, inspired by a post on Practicing Ruby, implements that 
  # kind of traversal for Ruby applications.
  #
  # Author:: Tammy Cravit (mailto:tammy@tammycravit.com)
  # Copyright:: Copyright (c) 2011, Tammy Cravit. All rights reserved.
  # License:: This program is free software: you can redistribute it and/or modify
  #           it under the terms of the GNU General Public License as published by
  #           the Free Software Foundation, either version 3 of the License, or
  #           (at your option) any later version.  
  module ConfigSearcher

    # Locate a configuration folder by starting in the specified directory
    # and traversing upward through the directory tree.
    #
    # === Options
    #
    # * +:start_in+ or +:start_dir+ - The directory in which to begin the
    # search. Defaults to the current directory if unspecified or if the
    # specified directory doesn't exist.
    # * +:look_for+ or +:config_dir+ - The name of the configuration directory
    # to look for. Defaults to +.config+ if unspecified.
    # * +:only_container_dir: - If this option is true, the +:look_for+ 
    # directory will not be returned as part of the path.
    #
    # === Returns
    #
    # If the configuration directory is found, its path will be returned as a
    # string. Otherwise, an empty string will be returned. If the +start_in+
    # directory doesn't exist, an exception will be raised.
    def self.locate_config_dir(opts={})
      start_dir           = opts[:start_in] || opts[:start_dir] || "."
      config_dir_name     = opts[:look_for] || opts[:config_dir] || ".config"
      only_container_dir  = opts[:only_container_dir] || false
      
      dir = Pathname.new(start_dir)
      app_config_dir = dir + config_dir_name
     
      begin
       if dir.children.include?(app_config_dir)
         if only_container_dir
           app_config_dir.to_s.split('/')[0..-2].join('/')
         else
           app_config_dir.expand_path.to_s
         end
       else  
         return nil if dir.expand_path.root?  
         # In the event the opts come from a hash that's used elsewhere, I don't
         # want to modify it, so I make a copy and replace the :start_in value.
         # I'm sure there's a better way to do this.
         locate_config_dir(opts.reject{|k,v| k == :start_in}.merge({start_in: dir.parent.to_s}))  
       end      
      rescue
        raise ArgumentError, "Start directory \"#{start_dir}\" doesn't exist"
      end
    end
  end
end
