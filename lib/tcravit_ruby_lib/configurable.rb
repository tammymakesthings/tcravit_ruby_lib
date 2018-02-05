############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : configurable.rb
# Description : Make a class configurable via a simple DSL
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

module TcravitRubyLib    #:nodoc:

# Make a class configurable via a DSL
#
# From https://www.toptal.com/ruby/ruby-dsl-metaprogramming-guide
#
# Sample Usage:
#
# class MyApp
#   include Configurable.with(:app_id, :title, :cookie_name)
# 
#   # ...
# end
#
# SomeClass.configure do
#   app_id "my_app"
#   title "My App"
#   cookie_name { "#{app_id}_session" }
# end

module Configurable

  # +nodoc+
  def self.with(*attrs)
    not_provided = Object.new
    config_class = Class.new do
      attrs.each do |attr|
        define_method attr do |value = not_provided, &block|
          if value === not_provided && block.nil?
            result = instance_variable_get("@#{attr}")
            result.is_a?(Proc) ? instance_eval(&result) : result
          else
            instance_variable_set("@#{attr}", block || value)
          end
        end
      end
      attr_writer *attrs
    end
    class_methods = Module.new do
      define_method :config do
        @config ||= config_class.new
      end
      def configure(&block)
        config.instance_eval(&block)
      end
    end
    Module.new do
      singleton_class.send :define_method, :included do |host_class|
        host_class.extend class_methods
      end
    end
  end
end
end
