module TcravitRubyLib #:nodoc:

  # Simple and Flexible Configuration Data Storage.
  #
  # AppConfig provides a simple facility for storing configuration data in
  # an application. It does this using metaprogramming techniques to define
  # accessor methods dynamically when the configuration file is loaded.
  #
  # This is far from the best way to do this, and was written as an exercise
  # in metaprogramming as much as anything else.
  #
  # === Example
  # 
  #     TcravitRubyLib::AppConfig.configure do
  #         some_value 1023
  #         another_value "Foo"
  #     end
  #     
  #     TcravitRubyLib::AppConfig.some_value      # => 1023
  #     TcravitRubyLib::AppConfig.some_value = 2048
  #     TcravitRubyLib::AppConfig.some_value     # => 2048
  #      
  # Author:: Tammy Cravit (mailto:tammy@tammycravit.com)
  # Copyright:: Copyright (c) 2011, Tammy Cravit. All rights reserved.
  # License:: This program is free software: you can redistribute it and/or modify
  #           it under the terms of the GNU General Public License as published by
  #           the Free Software Foundation, either version 3 of the License, or
  #           (at your option) any later version.
  
  module AppConfig
    extend self
    
    def configure(&block)
      @definitions ||= Hash.new

      # The method_missing auto-trigger should only run when we're inside
      # a configure block
      @in_config = true
      instance_eval &block
      @in_config = false
    end
    
    def remove!(key)
      the_sym = key.to_sym
      @definitions.delete(the_sym)
      send :undef_method, the_sym
      send :undef_method, "#{the_sym.to_s}=".to_sym      
    end
    
    def method_missing(methname, *args)
      if (methname.to_s =~ /^([A-Za-z0-9][A-Za-z0-9\-\_]+)$/)
        if @in_config
          getter_method_name = methname.to_s.to_sym
          setter_method_name = "#{methname}=".to_s.to_sym
          send :define_method, getter_method_name do
            @definitions[getter_method_name]
          end
          send :define_method, setter_method_name do |new_value|
            @definitions[getter_method_name] = new_value
          end
          send setter_method_name, (args.count > 0 ? args.first : nil)
        else
          super
        end
      else
        nil
      end
    end
  end
end
