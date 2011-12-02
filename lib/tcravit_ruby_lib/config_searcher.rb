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
    #
    # === Returns
    #
    # If the configuration directory is found, its path will be returned as a
    # string. Otherwise, an empty string will be returned. If the +start_in+
    # directory doesn't exist, an exception will be raised.
    def self.locate_config_dir(opts={})
      start_dir = opts[:start_in] || opts[:start_dir] || "."
      config_dir_name = opts[:look_for] || opts[:config_dir] || ".config"
      
      dir = Pathname.new(start_dir)
      app_config_dir = dir + config_dir_name
      
       if dir.children.include?(app_config_dir)  
         app_config_dir.expand_path.to_s
       else  
         return nil if dir.expand_path.root?  
         locate_config_dir(start_in: dir.parent.to_s, look_for: config_dir_name)  
       end      
    end
  end
end