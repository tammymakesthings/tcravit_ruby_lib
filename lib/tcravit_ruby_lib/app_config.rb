############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : app_config.rb
# Description : Simple and flexible DSL-like app config storage.
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

module TcravitRubyLib #:nodoc:

  ##
  ## Simple and Flexible Configuration Data Storage.
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
  
  module AppConfig
    extend self
   
    ##
    # Configure the settings.
    #
    # +configure+ accepts a block which is evaluated by `instance_eval`. 
    # Method calls inside this block are turned into app settings via
    # {#method_missing}, which dynamically creates getters and setters
    # for the provided values.
    #
    # As a side effect, this means you can't create app settings whose
    # name is the same as a ruby reserved word or a method defined by a
    # ruby `Object`, because those calls don't trigger {#method_missing}
    # to execute. In practice, this shouldn't be a huge limitation, but
    # it's worth being aware of.
    #
    # Configuration setting names must begin with an uppercase letter, 
    # lowercase letter, or digit. Dashes and underscores are permitted
    # after the initial character.
    #
    # @param block [Block] The configuration block.
    # @return Nothing, but stores the configuration values provided
    #         inside the block.
    def configure(&block)
      @definitions ||= Hash.new

      # The method_missing auto-trigger should only run when we're inside
      # a configure block
      @in_config = true
      instance_eval &block
      @in_config = false
    end
   
    #@
    # Remove a previously defined configuration value.
    #
    # {#remove} can be passed the name of the configuration setting as 
    # a string or a symbol. If the requested setting exists, its value
    # will be discarded, and the getter and setter methods will be
    # undefined. If the requested setting does not exist, no action is 
    # taken and no exceptions are raised.
    #
    # @param key [String] The configuration setting to remove. A symbol
    # can also be provided for the +key+.
    # @return Nothing.
    def remove!(key)
      the_sym = key.to_sym
      @definitions.delete(the_sym) if @definitions.include?(the_sym)
      send :undef_method, the_sym if self.respond_to?(the_sym)
      send :undef_method, "#{the_sym.to_s}=".to_sym if self.respond_to?("#{the_sym.to_s}=".to_sym)
    end
   
    #-nodoc-#
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
